Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D877AC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 18:45:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A78F5206B8
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 18:45:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729125AbfBZSpt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 13:45:49 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45653 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728736AbfBZSpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 13:45:49 -0500
Received: by mail-wr1-f67.google.com with SMTP id w17so15107531wrn.12
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 10:45:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vh4OOhMU6ok0vvq2PqJyeTthaOPa3BEiM/kIMdfGy2A=;
        b=tHzXopSdD6AMUMtu03ZdUa3azxTTu2LF3tU8je5Lp0WvcQZXhy50GTvT7JpNVwrRmH
         GuBugG3e8xAjmk00FQ9RfZKXMWmjrP4oRW9XgAkwr/8NdRDhBnJ19B6VAZ1PCtOj7Vaw
         HOQGVoGUo1vTxLJnv7pQRjp6NIyZiBGt2DMtD/KfOPkTsqhmmEVpz+HT1AdrX1o+JoMH
         fSNyvwl7RsErr9YEpbarXajWQG9q12oCIf9bWyEBNor/i4scjQPTA+yifWQ8maWywPeF
         2ghJbB/4Gh1LAh2M2l1pQ6Mxrgns5BtGPfLJqTd127T7ooe/pCl8Ux+AIzTUQ/3MxOmA
         aRzQ==
X-Gm-Message-State: AHQUAuaSQXUozstRCZHMSNeRAbMfpSZ/PkH0l4A716hwnQSEQg+JvRlp
        eI8TLdKWMzgkdhcc2uRVaNivnA==
X-Google-Smtp-Source: AHgI3IYyqbprnOkkpyZIHODXbNZB4Qd2Sud8ya/vVY0ab+ciJ56GBdNnKabLjzUy5VQNZevBdlXkQQ==
X-Received: by 2002:adf:d08d:: with SMTP id y13mr15864728wrh.99.1551206747621;
        Tue, 26 Feb 2019 10:45:47 -0800 (PST)
Received: from [192.168.1.37] (43.red-88-25-181.staticip.rima-tde.net. [88.25.181.43])
        by smtp.gmail.com with ESMTPSA id z10sm108951wml.39.2019.02.26.10.45.46
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Feb 2019 10:45:47 -0800 (PST)
Subject: Re: [Qemu-devel] [PATCH] fw_cfg: use __ATTR_RO_MODE to define rev
 sysfs
To:     Wei Yang <richardw.yang@linux.intel.com>, qemu-devel@nongnu.org,
        linux-kernel@vger.kernel.org
Cc:     somlo@cmu.edu, mst@redhat.com
References: <20190226073159.13434-1-richardw.yang@linux.intel.com>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <bf6ad77d-6514-57b3-141b-530f46500b57@redhat.com>
Date:   Tue, 26 Feb 2019 19:45:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190226073159.13434-1-richardw.yang@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wei,

On 2/26/19 8:31 AM, Wei Yang wrote:
> Leverage __ATTR_RO_MODE to define rev sysfs instead of using open code
> to define the attribute.
> 
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> ---
>  drivers/firmware/qemu_fw_cfg.c | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/firmware/qemu_fw_cfg.c b/drivers/firmware/qemu_fw_cfg.c
> index 039e0f91dba8..a1293cbd7adb 100644
> --- a/drivers/firmware/qemu_fw_cfg.c
> +++ b/drivers/firmware/qemu_fw_cfg.c
> @@ -296,18 +296,13 @@ static int fw_cfg_do_platform_probe(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -static ssize_t fw_cfg_showrev(struct kobject *k, struct attribute *a, char *buf)
> +static ssize_t fw_cfg_rev_show(struct kobject *k, struct kobj_attribute *a,
> +			       char *buf)
>  {
>  	return sprintf(buf, "%u\n", fw_cfg_rev);
>  }
> -
> -static const struct {
> -	struct attribute attr;
> -	ssize_t (*show)(struct kobject *k, struct attribute *a, char *buf);
> -} fw_cfg_rev_attr = {
> -	.attr = { .name = "rev", .mode = S_IRUSR },
> -	.show = fw_cfg_showrev,
> -};
> +static const struct kobj_attribute fw_cfg_rev_attr =
> +	__ATTR_RO_MODE(fw_cfg_rev, 0400);

Why not keep S_IRUSR?

>  
>  /* fw_cfg_sysfs_entry type */
>  struct fw_cfg_sysfs_entry {
> 
