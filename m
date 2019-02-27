Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F5A2C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 14:29:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 177D92133D
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 14:29:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KC/c/pyr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730674AbfB0O3G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 09:29:06 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:38362 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729870AbfB0O3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 09:29:06 -0500
Received: by mail-ed1-f66.google.com with SMTP id h58so14056528edb.5
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 06:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=cr4KhslSY7t+gtVy68WIj+Uo70M8IHJUlP623PRrhe8=;
        b=KC/c/pyrE/WHTy9S/ZFCFnRZr2WsRzeI+/jJv37PsoLgxvR7YSRV2edwLxsHaTd0H0
         1B4FAT5c+f52RuD6Xn9k//S0EzZuY4ePBxZLPEX8mKaKBtuyQTbilP+cjqzWqBVVavEL
         qxONc7M5mq2O22rVVX8zVrXNtqNfeNbCtUbeksZQZijg8puXJCHxxAtd90U1HVuGa/2I
         9flf5iYEFC0ahr0u13ay8g0KchvKpkUa4SiFHaCF1FzsGd48dAgojjWXnx0RwneJPLec
         oP7ckkuZSkzzhwI2Mu/KDzPHBL/ifx6fHlNqxwzX72kJmaZNYl2ok86vXgxjVYguv3Qb
         HV/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=cr4KhslSY7t+gtVy68WIj+Uo70M8IHJUlP623PRrhe8=;
        b=afOFRAbFhVs5q9kBfLtLqGtzh2jrGzb74JTSe1Si2X1CLfQbkqEcLEpN4kU6UXewL2
         /PQn12FvkjH35S6hr71P8dnDyirdokFDPjVGWHvLgzM6BtRIEgWqGHH6R6GB2yTxKDzh
         uBJPqRtL3UPS+sPH1XFFeoz8Rg/ckXn0IanXQLZuM+4FUR181mnPRydeIUcrF40pQGU2
         b89hDVmM3IWj9yReBI/rfprXTbH1MIx4dBmOIM6Z/Hkr2NnG3MlMuc20nR2cmr2OesD4
         kd2Gni0oMNse6RlAv7hXNH3ynPyy65fYUCe7qICp6ygEDwYKb/Mtys/LhMZ9UJKf1Gq2
         6dYA==
X-Gm-Message-State: AHQUAuZfNvd7BVhYQRHB1r8+RKHWGY4y5ofYi3w21bSlQ+hEFQcIhY3H
        qpqTHwqr9pGxhtGaZ/4At0E=
X-Google-Smtp-Source: AHgI3Ia/tX/nq7o1XqvE7ooQPs7xOoNaBZkxSVgk53fIlKxpmOqRdK3EHjPAm7u7S6+8ww2J6W2JFw==
X-Received: by 2002:a17:906:5784:: with SMTP id k4mr1743894ejq.107.1551277744793;
        Wed, 27 Feb 2019 06:29:04 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id d42sm4357204ede.30.2019.02.27.06.29.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Feb 2019 06:29:04 -0800 (PST)
Date:   Wed, 27 Feb 2019 14:29:03 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Wei Yang <richardw.yang@linux.intel.com>, somlo@cmu.edu,
        Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
        qemu-devel@nongnu.org, linux-kernel@vger.kernel.org
Subject: Re: [Qemu-devel] [PATCH] fw_cfg: use __ATTR_RO_MODE to define rev
 sysfs
Message-ID: <20190227142903.cvqrc453tgcme77f@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20190226073159.13434-1-richardw.yang@linux.intel.com>
 <bf6ad77d-6514-57b3-141b-530f46500b57@redhat.com>
 <20190227030715.GA5449@richard>
 <20190227085442-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190227085442-mutt-send-email-mst@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2019 at 08:54:58AM -0500, Michael S. Tsirkin wrote:
>On Wed, Feb 27, 2019 at 11:07:16AM +0800, Wei Yang wrote:
>> On Tue, Feb 26, 2019 at 07:45:46PM +0100, Philippe Mathieu-Daudé wrote:
>> >Hi Wei,
>> >
>> >On 2/26/19 8:31 AM, Wei Yang wrote:
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
>> >
>> >Why not keep S_IRUSR?
>> >
>> 
>> Because scripts/checkpatch.pl suggest not use S_IRUSR :-)
>> 
>> I am not sure about the particular reason.
>
>Oh yea.
>
>http://lkml.kernel.org/r/CA+55aFw5v23T-zvDZp-MmD_EYxF8WbafwwB59934FV7g21uMGQ@mail.gmail.com
>
>maybe mention this in the commit log.
>

Thanks :-)

>> >>  
>> >>  /* fw_cfg_sysfs_entry type */
>> >>  struct fw_cfg_sysfs_entry {
>> >> 
>> 
>> -- 
>> Wei Yang
>> Help you, Help me

-- 
Wei Yang
Help you, Help me
