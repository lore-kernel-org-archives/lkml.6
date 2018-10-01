Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33487C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 21:22:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF541208AE
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 21:22:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF541208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbeJBECE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 00:02:04 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:51321 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbeJBECE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 00:02:04 -0400
Received: from static-50-53-48-205.bvtn.or.frontiernet.net ([50.53.48.205] helo=[192.168.192.153])
        by youngberry.canonical.com with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <john.johansen@canonical.com>)
        id 1g75dw-0007zj-8e; Mon, 01 Oct 2018 21:22:16 +0000
Subject: Re: [PATCH security-next v3 16/29] LSM: Prepare for arbitrary LSM
 enabling
To:     Kees Cook <keescook@chromium.org>, James Morris <jmorris@namei.org>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        "Schaufler, Casey" <casey.schaufler@intel.com>,
        LSM <linux-security-module@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180925001832.18322-1-keescook@chromium.org>
 <20180925001832.18322-17-keescook@chromium.org>
From:   John Johansen <john.johansen@canonical.com>
Openpgp: preference=signencrypt
Autocrypt: addr=john.johansen@canonical.com; prefer-encrypt=mutual; keydata=
 xsFNBE5mrPoBEADAk19PsgVgBKkImmR2isPQ6o7KJhTTKjJdwVbkWSnNn+o6Up5knKP1f49E
 BQlceWg1yp/NwbR8ad+eSEO/uma/K+PqWvBptKC9SWD97FG4uB4/caomLEU97sLQMtnvGWdx
 rxVRGM4anzWYMgzz5TZmIiVTZ43Ou5VpaS1Vz1ZSxP3h/xKNZr/TcW5WQai8u3PWVnbkjhSZ
 PHv1BghN69qxEPomrJBm1gmtx3ZiVmFXluwTmTgJOkpFol7nbJ0ilnYHrA7SX3CtR1upeUpM
 a/WIanVO96WdTjHHIa43fbhmQube4txS3FcQLOJVqQsx6lE9B7qAppm9hQ10qPWwdfPy/+0W
 6AWtNu5ASiGVCInWzl2HBqYd/Zll93zUq+NIoCn8sDAM9iH+wtaGDcJywIGIn+edKNtK72AM
 gChTg/j1ZoWH6ZeWPjuUfubVzZto1FMoGJ/SF4MmdQG1iQNtf4sFZbEgXuy9cGi2bomF0zvy
 BJSANpxlKNBDYKzN6Kz09HUAkjlFMNgomL/cjqgABtAx59L+dVIZfaF281pIcUZzwvh5+JoG
 eOW5uBSMbE7L38nszooykIJ5XrAchkJxNfz7k+FnQeKEkNzEd2LWc3QF4BQZYRT6PHHga3Rg
 ykW5+1wTMqJILdmtaPbXrF3FvnV0LRPcv4xKx7B3fGm7ygdoowARAQABzR1Kb2huIEpvaGFu
 c2VuIDxqb2huQGpqbXgubmV0PsLBegQTAQoAJAIbAwULCQgHAwUVCgkICwUWAgMBAAIeAQIX
 gAUCTo0YVwIZAQAKCRAFLzZwGNXD2LxJD/9TJZCpwlncTgYeraEMeDfkWv8c1IsM1j0AmE4V
 tL+fE780ZVP9gkjgkdYSxt7ecETPTKMaZSisrl1RwqU0oogXdXQSpxrGH01icu/2n0jcYSqY
 KggPxy78BGs2LZq4XPfJTZmHZGnXGq/eDr/mSnj0aavBJmMZ6jbiPz6yHtBYPZ9fdo8btczw
 P41YeWoIu26/8II6f0Xm3VC5oAa8v7Rd+RWZa8TMwlhzHExxel3jtI7IzzOsnmE9/8Dm0ARD
 5iTLCXwR1cwI/J9BF/S1Xv8PN1huT3ItCNdatgp8zqoJkgPVjmvyL64Q3fEkYbfHOWsaba9/
 kAVtBNz9RTFh7IHDfECVaToujBd7BtPqr+qIjWFadJD3I5eLCVJvVrrolrCATlFtN3YkQs6J
 n1AiIVIU3bHR8Gjevgz5Ll6SCGHgRrkyRpnSYaU/uLgn37N6AYxi/QAL+by3CyEFLjzWAEvy
 Q8bq3Iucn7JEbhS/J//dUqLoeUf8tsGi00zmrITZYeFYARhQMtsfizIrVDtz1iPf/ZMp5gRB
 niyjpXn131cm3M3gv6HrQsAGnn8AJru8GDi5XJYIco/1+x/qEiN2nClaAOpbhzN2eUvPDY5W
 0q3bA/Zp2mfG52vbRI+tQ0Br1Hd/vsntUHO903mMZep2NzN3BZ5qEvPvG4rW5Zq2DpybWc7B
 TQROZqz6ARAAoqw6kkBhWyM1fvgamAVjeZ6nKEfnRWbkC94L1EsJLup3Wb2X0ABNOHSkbSD4
 pAuC2tKF/EGBt5CP7QdVKRGcQzAd6b2c1Idy9RLw6w4gi+nn/d1Pm1kkYhkSi5zWaIg0m5RQ
 Uk+El8zkf5tcE/1N0Z5OK2JhjwFu5bX0a0l4cFGWVQEciVMDKRtxMjEtk3SxFalm6ZdQ2pp2
 822clnq4zZ9mWu1d2waxiz+b5Ia4weDYa7n41URcBEUbJAgnicJkJtCTwyIxIW2KnVyOrjvk
 QzIBvaP0FdP2vvZoPMdlCIzOlIkPLgxE0IWueTXeBJhNs01pb8bLqmTIMlu4LvBELA/veiaj
 j5s8y542H/aHsfBf4MQUhHxO/BZV7h06KSUfIaY7OgAgKuGNB3UiaIUS5+a9gnEOQLDxKRy/
 a7Q1v9S+Nvx+7j8iH3jkQJhxT6ZBhZGRx0gkH3T+F0nNDm5NaJUsaswgJrqFZkUGd2Mrm1qn
 KwXiAt8SIcENdq33R0KKKRC80Xgwj8Jn30vXLSG+NO1GH0UMcAxMwy/pvk6LU5JGjZR73J5U
 LVhH4MLbDggD3mPaiG8+fotTrJUPqqhg9hyUEPpYG7sqt74Xn79+CEZcjLHzyl6vAFE2W0kx
 lLtQtUZUHO36afFv8qGpO3ZqPvjBUuatXF6tvUQCwf3H6XMAEQEAAcLBXwQYAQoACQUCTmas
 +gIbDAAKCRAFLzZwGNXD2D/XD/0ddM/4ai1b+Tl1jznKajX3kG+MeEYeI4f40vco3rOLrnRG
 FOcbyyfVF69MKepie4OwoI1jcTU0ADecnbWnDNHpr0SczxBMro3bnrLhsmvjunTYIvssBZtB
 4aVJjuLILPUlnhFqa7fbVq0ZQjbiV/rt2jBENdm9pbJZ6GjnpYIcAbPCCa/ffL4/SQRSYHXo
 hGiiS4y5jBTmK5ltfewLOw02fkexH+IJFrrGBXDSg6n2Sgxnn++NF34fXcm9piaw3mKsICm+
 0hdNh4afGZ6IWV8PG2teooVDp4dYih++xX/XS8zBCc1O9w4nzlP2gKzlqSWbhiWpifRJBFa4
 WtAeJTdXYd37j/BI4RWWhnyw7aAPNGj33ytGHNUf6Ro2/jtj4tF1y/QFXqjJG/wGjpdtRfbt
 UjqLHIsvfPNNJq/958p74ndACidlWSHzj+Op26KpbFnmwNO0psiUsnhvHFwPO/vAbl3RsR5+
 0Ro+hvs2cEmQuv9r/bDlCfpzp2t3cK+rhxUqisOx8DZfz1BnkaoCRFbvvvk+7L/fomPntGPk
 qJciYE8TGHkZw1hOku+4OoM2GB5nEDlj+2TF/jLQ+EipX9PkPJYvxfRlC6dK8PKKfX9KdfmA
 IcgHfnV1jSn+8yH2djBPtKiqW0J69aIsyx7iV/03paPCjJh7Xq9vAzydN5U/UA==
Organization: Canonical
Message-ID: <b16a8882-4e88-0340-84b4-0fd2f8797206@canonical.com>
Date:   Mon, 1 Oct 2018 14:22:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180925001832.18322-17-keescook@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/24/2018 05:18 PM, Kees Cook wrote:
> Before now, all the LSMs that did not specify an "enable" variable in their
> struct lsm_info were considered enabled by default. This prepares to make
> LSM enabling more explicit. For all LSMs without an explicit "enable"
> variable, a hard-coded storage location is chosen, and all LSMs without
> an external "enable" state have their state explicitly set to "enabled".
> 
> This code appears more complex than it needs to be (comma-separated
> list parsing and "set" function parameter) because its use will be
> expanded on in the following patches to provide more explicit enabling.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>


Reviewed-by: John Johansen <john.johansen@canonical.com>


> ---
>  security/security.c | 69 ++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 65 insertions(+), 4 deletions(-)
> 
> diff --git a/security/security.c b/security/security.c
> index 056b36cf6245..a8107d54b3d3 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -54,17 +54,46 @@ static bool debug __initdata;
>  
>  static bool __init is_enabled(struct lsm_info *lsm)
>  {
> -	if (!lsm->enabled || *lsm->enabled)
> -		return true;
> +	if (WARN_ON(!lsm->enabled))
> +		return false;
>  
> -	return false;
> +	return *lsm->enabled;
>  }
>  
>  /* Mark an LSM's enabled flag, if it exists. */
> -static void __init set_enabled(struct lsm_info *lsm, bool enabled)
> +static int lsm_enabled_true __initdata = 1;
> +static int lsm_enabled_false __initdata = 0;
> +
> +static void __init default_enabled(struct lsm_info *lsm, bool enabled)
>  {
> +	/* If storage location already set, skip this one. */
>  	if (lsm->enabled)
> +		return;
> +
> +	/*
> +	 * When an LSM hasn't configured an enable variable, we can use
> +	 * a hard-coded location for storing the default enabled state.
> +	 */
> +	if (enabled)
> +		lsm->enabled = &lsm_enabled_true;
> +	else
> +		lsm->enabled = &lsm_enabled_false;
> +}
> +
> +static void __init set_enabled(struct lsm_info *lsm, bool enabled)
> +{
> +	if (WARN_ON(!lsm->enabled))
> +		return;
> +
> +	if (lsm->enabled == &lsm_enabled_true) {
> +		if (!enabled)
> +			lsm->enabled = &lsm_enabled_false;
> +	} else if (lsm->enabled == &lsm_enabled_false) {
> +		if (enabled)
> +			lsm->enabled = &lsm_enabled_true;
> +	} else {
>  		*lsm->enabled = enabled;
> +	}
>  }
>  
>  /* Is an LSM allowed to be initialized? */
> @@ -127,6 +156,35 @@ static void __init major_lsm_init(void)
>  	}
>  }
>  
> +static void __init parse_lsm_enable(const char *str,
> +				    void (*set)(struct lsm_info *, bool),
> +				    bool enabled)
> +{
> +	char *sep, *name, *next;
> +
> +	if (!str)
> +		return;
> +
> +	sep = kstrdup(str, GFP_KERNEL);
> +	next = sep;
> +	while ((name = strsep(&next, ",")) != NULL) {
> +		struct lsm_info *lsm;
> +
> +		for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
> +			if (strcmp(name, "all") == 0 ||
> +			    strcmp(name, lsm->name) == 0)
> +				set(lsm, enabled);
> +		}
> +	}
> +	kfree(sep);
> +}
> +
> +static void __init prepare_lsm_enable(void)
> +{
> +	/* Prepare defaults. */
> +	parse_lsm_enable("all", default_enabled, true);
> +}
> +
>  /**
>   * security_init - initializes the security framework
>   *
> @@ -143,6 +201,9 @@ int __init security_init(void)
>  	     i++)
>  		INIT_HLIST_HEAD(&list[i]);
>  
> +	/* Figure out which LSMs are enabled and disabled. */
> +	prepare_lsm_enable();
> +
>  	/*
>  	 * Load minor LSMs, with the capability module always first.
>  	 */
> 

