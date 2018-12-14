Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AD4BC67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 04:06:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F6D620879
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 04:06:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="TpdsM15S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F6D620879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbeLNEGv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 23:06:51 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37737 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbeLNEGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 23:06:51 -0500
Received: by mail-pg1-f196.google.com with SMTP id c25so559027pgb.4
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 20:06:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OFw4yzDyOHSC5n9Hi8nCtKnbyc7DAS/g61Kj7UOF3Rc=;
        b=TpdsM15SXCQm5YlHHw5EmE2zCVBk751R4FDn0uhe5l2uPkRsL08SU+MUfERoustL3c
         r/74ZJ45J3hhnqZnUXnnY/2kvwyC4sXZEHCr5KFiWhRnlG+Ozjinwq+CFo7mgXBFwH+I
         DO9GVctweTbtjWwKE9P1ylqj7tS2RxIl9SzL1VwIJzbj+mym6NpBEbP+gdAs/YWkB7nP
         PSlsOlugCSrr9YmQQCUzQLzr1HgKxZDaXd7NtyVIAXbB1NUfH/OUdPeU9kxdaSZQ2u92
         VZYEMYMzCng8ZYCjM3/v1hTkQCBWRJrG09+jO/KhUnrSN920CvO1l84AYf0vTUKOWnwO
         zktQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OFw4yzDyOHSC5n9Hi8nCtKnbyc7DAS/g61Kj7UOF3Rc=;
        b=rOfdiOQ0HPoXMtnKaIoVdrJnKVIdTmnTQ3td5DWB2iEa59WmIs3GNAd/Gb6ogsj3zA
         sBBgkrxh7g4anYjFyjArH151eyYhdK6xw5GOU+fQW+tJSIyUMlEnNIM633h2tWBkUDeI
         1lVqQOW7cQPdrmjFKxie9+XNc2cjJDwVd2E3IedwNkR/d2W0wMoZowSJgDvHIEBW0y1Q
         GYHC2yLQCUliPGXbnmQHYhh7vDbRde9UZpG5Vhejw2UexTdpomtyQEAattf7UtkngDEk
         anZdc4v47c/fR5TK0IoTLkrFy95+/YHcfCLO4ZTx31CF2Rabt6DXNSa5HZdpqZu/cjcm
         Ymew==
X-Gm-Message-State: AA+aEWYSrfD7kcT71kGgsmcR2qGYG9+pcYVFT7Zf/OjFqiDsFuJJa3u9
        aWEd4VvN7vLLdawVIUoNAVC9bN7sHxg7fA==
X-Google-Smtp-Source: AFSGD/Xwp9kuSXM+5L6NEHUw6kLPpJIWGxbSTTnA+jEYuh5yo0FVqUXU5iDaKBo8IrjM5eVgymtG2g==
X-Received: by 2002:a63:de04:: with SMTP id f4mr1358035pgg.292.1544760410531;
        Thu, 13 Dec 2018 20:06:50 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id t2sm5205731pfm.32.2018.12.13.20.06.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Dec 2018 20:06:49 -0800 (PST)
Subject: Re: linux-next: manual merge of the block tree with the scsi-fixes
 tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
References: <20181214132315.601d020f@canb.auug.org.au>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a48f78a5-901b-20be-8df0-d69770710932@kernel.dk>
Date:   Thu, 13 Dec 2018 21:06:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181214132315.601d020f@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/13/18 7:23 PM, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the block tree got a conflict in:
> 
>   drivers/scsi/sd.c
> 
> between commit:
> 
>   61cce6f6eece ("scsi: sd: use mempool for discard special page")
> 
> from the scsi-fixes tree and commit:
> 
>   159b2cbf59f4 ("scsi: return blk_status_t from scsi_init_io and ->init_command")
> 
> from the block tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

Martin, I can carry this one to avoid this conflict. Let me know!

-- 
Jens Axboe

