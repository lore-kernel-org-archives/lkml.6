Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3134BC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 14:26:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E738D2133D
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 14:26:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T36QOp7A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730629AbfB0O0z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 09:26:55 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40029 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730070AbfB0O0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 09:26:55 -0500
Received: by mail-ed1-f67.google.com with SMTP id 10so14037822eds.7
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 06:26:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vlK1GWcdIPlzxKouEhuPLcTndvXXr/ukgje/AbBtDVI=;
        b=T36QOp7ACggUv5Bp3/PTGcNwyXlTs9l76UnX3SOWlInXdkK3Juvy7g7GEaUP4I16c1
         QnrtUJFgXWUaaEjl1ha1qDiwtgeZbtkzcNu3N7jffuSyWVnfvS5D+d1LJaN7Xcow/PN/
         ksRZ9yP0vlvY8yCvDF3BYhOcN6gRpEVoUO/8LqNml1K5G/9kc4Qnm2UzOtHHZj1alXc2
         cUEpMNR7wRR/SdHT+hyKJS0ovS/xncEkewh79RnWoq4R0cD9ppXMtmVQF9lFFnzDYEAZ
         XfFbSRfgBWUHjZxHOtGiH+6Zzsd8J9878pJsQyAvToUNf4+qy1AOZgxhkHO4Zrdg2VJJ
         zebA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=vlK1GWcdIPlzxKouEhuPLcTndvXXr/ukgje/AbBtDVI=;
        b=nO7t1Xb5/xX3RFyw+5oF7ifbeVFf3UOwbZ8xNUJwP9iyHL8J4L/fgXm01jnnX0GYRg
         x9UHJoUUFS4CQcc8ZS4cvBNKTlOmpNhxx9BO0lBCMH/kvU5wYz2arZPg7t+LtPdSRtgv
         Xt08eVVSdyb5LEHrDMOPgrzBUB6vs3zqcLfZasGTAdaKkU09iaLgTFWtoeGqo782ctYt
         zm/szjBwTSv0AbUDZogDGHwKlFIuTcmVa24i2SX8HB04UmYeoaM9zdIJB0AHFCY/68Kv
         i6Gx78SWVE+KvB1mMt2Lt1W0sa46GErSejSU+GF32sfm4qnhx3gMI+mBHR0/O/e20ujt
         6zbA==
X-Gm-Message-State: AHQUAubCLTplIWw9kqC//lDxBIFKz+hibItct0tNyqeop9/6/r9r3ciM
        Ad2ut2Ll/5b5uAxva0N5STGBEJYw
X-Google-Smtp-Source: AHgI3IbNZrLvUeUkoOmplant31RU/J6YdnbC6YssVT/ggxrWUhsbPtmmLNwO1z+Bjen8dlHMUY8Zhw==
X-Received: by 2002:a17:906:4ec6:: with SMTP id i6mr1787295ejv.56.1551277613261;
        Wed, 27 Feb 2019 06:26:53 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id d17sm2736063ejm.35.2019.02.27.06.26.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Feb 2019 06:26:52 -0800 (PST)
Date:   Wed, 27 Feb 2019 14:26:51 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Wei Yang <richardw.yang@linux.intel.com>, somlo@cmu.edu,
        qemu-devel@nongnu.org, linux-kernel@vger.kernel.org
Subject: Re: [Qemu-devel] [PATCH] fw_cfg: use __ATTR_RO_MODE to define rev
 sysfs
Message-ID: <20190227142651.3enr2eey5bn2v6ls@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20190226073159.13434-1-richardw.yang@linux.intel.com>
 <20190226110934-mutt-send-email-mst@kernel.org>
 <20190227053319.GB5449@richard>
 <20190227084843-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190227084843-mutt-send-email-mst@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2019 at 08:51:11AM -0500, Michael S. Tsirkin wrote:
>On Wed, Feb 27, 2019 at 01:33:19PM +0800, Wei Yang wrote:
>> On Tue, Feb 26, 2019 at 11:10:06AM -0500, Michael S. Tsirkin wrote:
>> >On Tue, Feb 26, 2019 at 03:31:59PM +0800, Wei Yang wrote:
>> >> Leverage __ATTR_RO_MODE to define rev sysfs instead of using open code
>> >> to define the attribute.
>> >> 
>> >> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>> >> ---
>> >>  drivers/firmware/qemu_fw_cfg.c | 13 ++++---------
>> >>  1 file changed, 4 insertions(+), 9 deletions(-)
>> >> 
>> >> diff --git a/drivers/firmware/qemu_fw_cfg.c b/drivers/firmware/qemu_fw_cfg.c
>> >> index 039e0f91dba8..a1293cbd7adb 100644
>> >> --- a/drivers/firmware/qemu_fw_cfg.c
>> >> +++ b/drivers/firmware/qemu_fw_cfg.c
>> >> @@ -296,18 +296,13 @@ static int fw_cfg_do_platform_probe(struct platform_device *pdev)
>> >>  	return 0;
>> >>  }
>> >>  
>> >> -static ssize_t fw_cfg_showrev(struct kobject *k, struct attribute *a, char *buf)
>> >> +static ssize_t fw_cfg_rev_show(struct kobject *k, struct kobj_attribute *a,
>> >> +			       char *buf)
>> >>  {
>> >>  	return sprintf(buf, "%u\n", fw_cfg_rev);
>> >>  }
>> >> -
>> >> -static const struct {
>> >> -	struct attribute attr;
>> >> -	ssize_t (*show)(struct kobject *k, struct attribute *a, char *buf);
>> >> -} fw_cfg_rev_attr = {
>> >> -	.attr = { .name = "rev", .mode = S_IRUSR },
>> >> -	.show = fw_cfg_showrev,
>> >> -};
>> >> +static const struct kobj_attribute fw_cfg_rev_attr =
>> >> +	__ATTR_RO_MODE(fw_cfg_rev, 0400);
>> >>  
>> >>  /* fw_cfg_sysfs_entry type */
>> >>  struct fw_cfg_sysfs_entry {
>> >
>> >
>> >Looks like this will change the name from "rev" to "fw_cfg_rev".
>> >That's a userspace visible change which we should not do lightly.
>> 
>> You are right, I should keep the interface untouched.
>> 
>> To keep it user un-visible, we could change like below:
>> 
>> -       __ATTR_RO(fw_cfg_rev);
>> +       __ATTR_RO(rev);
>> 
>> Is this better for you?
>
>
>Also why use 0400 and not S_IRUSR?
>

This is interesting. The scripts/checkpatch.pl suggest to use 0400.

I am not sure why the script give this suggestion. Maybe we need to fix
the script?

>> >> -- 
>> >> 2.19.1
>> 
>> -- 
>> Wei Yang
>> Help you, Help me

-- 
Wei Yang
Help you, Help me
