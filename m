Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 092AFC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 21:24:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB966222A4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 21:24:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="eMesfIsT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388390AbfBMVYj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 16:24:39 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36591 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731603AbfBMVYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 16:24:38 -0500
Received: by mail-pl1-f195.google.com with SMTP id g9so1826870plo.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 13:24:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=yeAjm3sD6HABTKF5lTqi5rMY7hak/gCVzVuUnx3tjeo=;
        b=eMesfIsTzx3CzUOWsVg9+u7b+PHxNEYbreIFctULKDyP6D/7zJBtU6gUgFdFW24nSB
         jX22rOSBr/Kow6ZwJcrxVjlWG7ZFxfB85Lsop2K1fXfON6khvZKl+Z3aIBMS4U+o6uGq
         EAc6uXN38rzqwrX29CKqYSTOsND5rmpWfXFUg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=yeAjm3sD6HABTKF5lTqi5rMY7hak/gCVzVuUnx3tjeo=;
        b=B/kN7CtjnSZizIObDEkPxqdVi5zSSdMEvCubd0geb59OQlIGUN++Be4oNvutmSkp9N
         q0sn7zl4RRN4MkumeVlJlY1s7TI5azxubJJW82LwDO9buTqwy3wqOtxUmzebV5mjc2CF
         zxnumBu18zH5deQu/uHT3vpjKpgagZZYL7qGRat1P8dy/eLB/9R5AFK44SUVYIWdQua/
         J9PlTPGMTNk0NeBThnqRxDuQhLbYX/44PF+PpMFLYcT+OhnQ1TAytPbOcA+zCF5cv4zZ
         XsQPdS/5JaaQyT6KzUDVDnppRM+X0PQUjiHIuz5+n4BOOivL627b7swLpjqrst+/Vorl
         FgSg==
X-Gm-Message-State: AHQUAuZdTX2v4BVHllVRQC4RGBUIgYGFRtwNch6E8DkCEeYWa0Pe8wnN
        5Jyg74U6GEz60LDbbxpAvsM3+4P4V9ex9yx4AiBSrMur+dO2UL+k4rb9nxfI325HITqndqyT3JS
        CfXqUqJZIErigaCwbvQOpXEuipetDCb0qVOsHa+eYB9nNw0ZppeWq1+AX9M8/KpjX3PfgRzSqke
        TvrF6OiQ==
X-Google-Smtp-Source: AHgI3IZDshbuiEJvebry30TbKuvXxcYiL+ELo/B7PX2KNs/Abs8v1mZUFddoD65LZ3E9sNos+2dYpg==
X-Received: by 2002:a17:902:5a8d:: with SMTP id r13mr272127pli.190.1550093077257;
        Wed, 13 Feb 2019 13:24:37 -0800 (PST)
Received: from [10.69.52.190] ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id d88sm357300pfe.19.2019.02.13.13.24.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 13:24:36 -0800 (PST)
Subject: Re: [PATCH] scsi: lpfc: fix a handful of indentation issues
To:     Colin King <colin.king@canonical.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190212152945.11362-1-colin.king@canonical.com>
From:   James Smart <james.smart@broadcom.com>
Message-ID: <318e23da-04ee-87d0-644b-c1f87a1c5316@broadcom.com>
Date:   Wed, 13 Feb 2019 13:24:34 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190212152945.11362-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/12/2019 7:29 AM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> There are a handful of statements that are indented incorrectly. Fix these.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>   drivers/scsi/lpfc/lpfc_bsg.c     | 4 ++--
>   drivers/scsi/lpfc/lpfc_debugfs.c | 4 ++--
>   drivers/scsi/lpfc/lpfc_init.c    | 2 +-
>   drivers/scsi/lpfc/lpfc_mbox.c    | 4 ++--
>   drivers/scsi/lpfc/lpfc_sli.c     | 2 +-
>   5 files changed, 8 insertions(+), 8 deletions(-)
>
>

Looks good to me.

Signed-off-by:  James Smart   <james.smart@broadcom.com>

-- james

