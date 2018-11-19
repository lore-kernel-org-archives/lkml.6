Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB74FC4161D
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 21:25:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 919A52080C
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 21:25:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 919A52080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731061AbeKTHvO convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 02:51:14 -0500
Received: from mga05.intel.com ([192.55.52.43]:58023 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730141AbeKTHvO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 02:51:14 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Nov 2018 13:25:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,254,1539673200"; 
   d="scan'208";a="109618991"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by orsmga001.jf.intel.com with ESMTP; 19 Nov 2018 13:25:41 -0800
Received: from fmsmsx121.amr.corp.intel.com (10.18.125.36) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Mon, 19 Nov 2018 13:25:40 -0800
Received: from lcsmsx154.ger.corp.intel.com (10.186.165.229) by
 fmsmsx121.amr.corp.intel.com (10.18.125.36) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Mon, 19 Nov 2018 13:25:40 -0800
Received: from hasmsx108.ger.corp.intel.com ([169.254.9.165]) by
 LCSMSX154.ger.corp.intel.com ([169.254.7.79]) with mapi id 14.03.0415.000;
 Mon, 19 Nov 2018 23:25:23 +0200
From:   "Winkler, Tomas" <tomas.winkler@intel.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
CC:     "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        "Struk, Tadeusz" <tadeusz.struk@intel.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        "Nayna Jain" <nayna@linux.ibm.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        "Jason Gunthorpe" <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v9 04/17] tpm: print tpm2_commit_space() error inside
 tpm2_commit_space()
Thread-Topic: [PATCH v9 04/17] tpm: print tpm2_commit_space() error inside
 tpm2_commit_space()
Thread-Index: AQHUfz0HV9TuDcLLJkegLXS35AC8EqVXnOgQ
Date:   Mon, 19 Nov 2018 21:25:22 +0000
Message-ID: <5B8DA87D05A7694D9FA63FD143655C1B9DA23561@hasmsx108.ger.corp.intel.com>
References: <20181118124753.18613-1-jarkko.sakkinen@linux.intel.com>
 <20181118124753.18613-5-jarkko.sakkinen@linux.intel.com>
In-Reply-To: <20181118124753.18613-5-jarkko.sakkinen@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNzAxYWQwMDYtNzFiZC00YTcwLWI4MTctYTYzZjJkYzE1MDllIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiakY4NEhrY2JYV2xkYndOTm1HdmlcL3YyXC9JYjFFRHlcL2U3UUhiQlFVcHk0N0FiNmY3dzZYTk1DZ1B0OVN1XC8xNzEifQ==
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.12.116.75]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> 
> The error logging for tpm2_commit_space() is in a wrong place. This commit
> moves it inside that function.
> 
> Cc: James Bottomley <James.Bottomley@HansenPartnership.com>
> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> ---
>  drivers/char/tpm/tpm-interface.c | 2 --
>  drivers/char/tpm/tpm2-space.c    | 9 ++++++---
>  2 files changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-
> interface.c
> index 64510ed81b46..7ac6ada8428c 100644
> --- a/drivers/char/tpm/tpm-interface.c
> +++ b/drivers/char/tpm/tpm-interface.c
> @@ -277,8 +277,6 @@ static ssize_t tpm_try_transmit(struct tpm_chip
> *chip,
>  	}
> 
>  	rc = tpm2_commit_space(chip, space, ordinal, buf, &len);
> -	if (rc)
> -		dev_err(&chip->dev, "tpm2_commit_space: error %d\n", rc);
> 
>  out:
>  	/* may fail but do not override previous error value in rc */ diff --git
> a/drivers/char/tpm/tpm2-space.c b/drivers/char/tpm/tpm2-space.c index
> 1131a8e7b79b..5ecc73988f7c 100644
> --- a/drivers/char/tpm/tpm2-space.c
> +++ b/drivers/char/tpm/tpm2-space.c
> @@ -501,19 +501,19 @@ int tpm2_commit_space(struct tpm_chip *chip,
> struct tpm_space *space,
>  	rc = tpm2_map_response_header(chip, cc, buf, *bufsiz);
>  	if (rc) {
>  		tpm2_flush_space(chip);
> -		return rc;
> +		goto out;
>  	}
> 
>  	rc = tpm2_map_response_body(chip, cc, buf, *bufsiz);
>  	if (rc) {
>  		tpm2_flush_space(chip);
> -		return rc;
> +		goto out;
>  	}
> 
>  	rc = tpm2_save_space(chip);
>  	if (rc) {
>  		tpm2_flush_space(chip);
> -		return rc;
> +		goto out;
>  	}
> 
>  	*bufsiz = be32_to_cpu(header->length); @@ -526,4 +526,7 @@ int
> tpm2_commit_space(struct tpm_chip *chip, struct tpm_space *space,
>  	memcpy(space->session_buf, chip->work_space.session_buf,
> PAGE_SIZE);
> 
>  	return 0;
> +out:
Maybe 'out' is too positive name for an error-only exit point? 
or you can use if (rc) ... dev_err()
> +	dev_err(&chip->dev, "%s: error %d\n", __func__, rc);
> +	return rc;
>  }
> --
> 2.19.1

