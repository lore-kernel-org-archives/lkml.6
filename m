Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49F83C28CF6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 15:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E34C520842
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 15:47:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jCE527BX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E34C520842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729188AbeG1ROM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 13:14:12 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37047 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729153AbeG1ROM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 13:14:12 -0400
Received: by mail-wr1-f66.google.com with SMTP id q10-v6so8065827wrd.4;
        Sat, 28 Jul 2018 08:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Tzk/brVbDl3wzc6QJfG2imPme6YmKF+/7IGF8N1asxU=;
        b=jCE527BXmY9gOM1k3prTvDe+Ak4RojCgCeN0V/kYMIgQwvlYOhlBDH8ZZ4LcjomavY
         MdHyc1WuEF4rrSJ7eITHRn/JoIrHADx9BkcTwl7QtpF/kX6YZK8rJMpWL5dG23EgrXLk
         9C1Az288t9o2etFKkOMkYmkBfOPkdI5OHOKPA8AuWd7Y3kGhFwL4mdhb8pGAX5oNXxUS
         MYNOyWqXB2bkXaQuEC6DPFWpSE4CBWlsTo61itYjjFGmKyQBxz1MmSSkuXAXUA4NJwVL
         sAOasX7OvaARjDg9ZvIbJVA2V6QxmHz2X1iBA8cPX8r8C0kRnukVlyo5DF9XZd1Ckw40
         vg8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Tzk/brVbDl3wzc6QJfG2imPme6YmKF+/7IGF8N1asxU=;
        b=Sb5aQgBCW0jeoHeG09OHrjr3kMsHgLThMMcmN+TJbcDvSFl5zrbP5suAXJ7jYzXiNm
         DC9tEmzlaAhx3/EfB3GLypu3DzkflqOn4nikTVrchXwoyMFSU1dJHxqhXk/50guzvsw5
         saScgAAVVgcuHxdIPfboSL/NL8zBm442qtvEY3eLTHrzvLxkWsOeHJwiS4qjvcqHhPvB
         gIQfEFNjrpkBKYbN/c+xCSmJN9uZX+XbNHWCz6IdsMPFtOZ5d/nJC4gBaJoIRSUE0Cr9
         G5HMryiqdHDuTy3xdTztJNRV1B98dzS4/NZpoVol9gN4pNcC4czJQbLgyH2TbKMPSD7N
         bPjg==
X-Gm-Message-State: AOUpUlH+oxkxnYo68Qch6zQKLTyQ0JTXyCBAzf6VM5A71eIyBSBNbqzt
        NK1rdI6xFARbCzAGEaXtms9w7W3S
X-Google-Smtp-Source: AAOMgpcHKqWZ0aTThZRuomHGvsqcqtrK9sW+UvcpTXydrAu3E0p7EwvRWPUQrXBRxzU0UrG1I19RnQ==
X-Received: by 2002:adf:91e5:: with SMTP id 92-v6mr9937523wri.124.1532792834900;
        Sat, 28 Jul 2018 08:47:14 -0700 (PDT)
Received: from ?IPv6:2003:ea:8bd4:d600:b592:ff44:ca24:be74? (p200300EA8BD4D600B592FF44CA24BE74.dip0.t-ipconnect.de. [2003:ea:8bd4:d600:b592:ff44:ca24:be74])
        by smtp.googlemail.com with ESMTPSA id b11-v6sm11920469wma.34.2018.07.28.08.47.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 28 Jul 2018 08:47:14 -0700 (PDT)
Subject: Re: [PATCH net-next] sysfs: Fix regression when adding a file to an
 existing group
To:     Tyler Hicks <tyhicks@canonical.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <1532727207-10912-1-git-send-email-tyhicks@canonical.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <c4c53658-be9e-6c33-1d23-f1bcb3301f48@gmail.com>
Date:   Sat, 28 Jul 2018 17:47:08 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1532727207-10912-1-git-send-email-tyhicks@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.07.2018 23:33, Tyler Hicks wrote:
> Commit 5f81880d5204 ("sysfs, kobject: allow creating kobject belonging
> to arbitrary users") incorrectly changed the argument passed as the
> parent parameter when calling sysfs_add_file_mode_ns(). This caused some
> sysfs attribute files to not be added correctly to certain groups.
> 
> Fixes: 5f81880d5204 ("sysfs, kobject: allow creating kobject belonging to arbitrary users")
> Signed-off-by: Tyler Hicks <tyhicks@canonical.com>
> Reported-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
> 
> Note, this was a regression exclusively in linux-next and never made it to
> Linus' tree. There's no need to queue it up for linux-stable.
> 
>  fs/sysfs/file.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/sysfs/file.c b/fs/sysfs/file.c
> index fa46216523cf..052e5ad9a4d2 100644
> --- a/fs/sysfs/file.c
> +++ b/fs/sysfs/file.c
> @@ -373,7 +373,7 @@ int sysfs_add_file_to_group(struct kobject *kobj,
>  		return -ENOENT;
>  
>  	kobject_get_ownership(kobj, &uid, &gid);
> -	error = sysfs_add_file_mode_ns(kobj->sd, attr, false,
> +	error = sysfs_add_file_mode_ns(parent, attr, false,
>  				       attr->mode, uid, gid, NULL);
>  	kernfs_put(parent);
>  
> 
Tested-by: Heiner Kallweit <hkallweit1@gmail.com>
