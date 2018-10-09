Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B88AC43441
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 23:12:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3AC0214C4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 23:12:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ue4DJnx2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3AC0214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbeJJGbX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 02:31:23 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42134 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725748AbeJJGbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 02:31:23 -0400
Received: by mail-pf1-f196.google.com with SMTP id f26-v6so1604656pfn.9;
        Tue, 09 Oct 2018 16:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n9o+0mUvakxF9zd62BnmGXO0bWRmy7X7UMKfpuns3T8=;
        b=Ue4DJnx2CHoghdY7U/QDpHeJu/vrHXYyixuBmiW5Jj0ho5HqSS03jPRvQ7a7eCKZbk
         wuO6NR7pOOb5iy0tYgIPbFUamhhwA/UZ2QZzF2ZN+XV2K53b+aCdAlhNIOGos34qNSVN
         vQgjgiWGlSpRknco3DuLyVqbl2pCw0XBKImMNlv2FIWBVqJc7hXKPP84iokQpMY0WrW5
         K2llVGaWV2vCfmNkCF2p4wyII8UXngT8VSSU1mpA5/7QFikNLN1zctjXAzLKGKNlmUn8
         RagVdN2jTCdcA7Kb5SLrlsMgwPYuuUTNlgEE4Cn/iTkGxvLhkCACwUjm93CShULJ+E40
         +PHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n9o+0mUvakxF9zd62BnmGXO0bWRmy7X7UMKfpuns3T8=;
        b=thg4PxKA2sDiXsayp9v0eJiNjuBqzdGtiz0KGwp3MyT11oFf+DvP5JNDKuSonOglcE
         WYCPHq/cxnDcucY3DfZ9AxPrFVHwQzsZnCd3IzO8EzkYNO4eANVtUpYWgfGECCJ8WaQ4
         1J72Oq1XbVonIs0B+1cxF9r093OWPsZLf45cAsnpdV6kFRcgeKMH7aEuiEDOYF6rwm8W
         a3+PcPk+rzkORi4EPVyylOM2k3vlT2/gp8qT/djkkQR4Hj1WG3Q5OJ7+9HTnw4sUdItS
         uI5XdLnvlE2TFr1MH55ZXNLcjYdz5yxZFAbs5HzpkIAbvYFEsjFNu5VpH4i3oGkPJNkb
         oIqQ==
X-Gm-Message-State: ABuFfoixSf5rez77Xhldu6wmXETH82lLKkAkMEHarB0Oc/GkH14eBIPJ
        f+Ez4HBe6GdR9SyXzZKAitFAi0jdp4dxuqlSCuU=
X-Google-Smtp-Source: ACcGV63yTh5vIO4EOfn9JW/IRTgwHieIoasfkKPdkapaIG9YLI+4gGDnyYWGNaMCphzf9iI34G/EDiiizNFMUXshATE=
X-Received: by 2002:a63:6b05:: with SMTP id g5-v6mr27695371pgc.344.1539126726772;
 Tue, 09 Oct 2018 16:12:06 -0700 (PDT)
MIME-Version: 1.0
References: <20181009220220.GA24569@embeddedor.com>
In-Reply-To: <20181009220220.GA24569@embeddedor.com>
From:   Steve French <smfrench@gmail.com>
Date:   Tue, 9 Oct 2018 18:11:55 -0500
Message-ID: <CAH2r5mvMBaC-OMOcVv-ohwFck2fwS7-ZghCtvYithcO54G9uZQ@mail.gmail.com>
Subject: Re: [PATCH v3] smb2: fix uninitialized variable bug in smb2_ioctl_query_info
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Steve French <sfrench@samba.org>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        CIFS <linux-cifs@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added Ronnie's reviewed-by and pushed to cifs-2.6.git for-next
On Tue, Oct 9, 2018 at 5:27 PM Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
>
> There is a potential execution path in which variable *resp_buftype*
> is passed as an argument to function free_rsp_buf(), in which it is
> used in a comparison without being properly initialized previously.
>
> Fix this by initializing variable *resp_buftype* to CIFS_NO_BUFFER
> in order to avoid unpredictable or unintended results.
>
> Addresses-Coverity-ID: 1473971 ("Uninitialized scalar variable")
> Fixes: c5d25bdb2967 ("cifs: add IOCTL for QUERY_INFO passthrough to userspace")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
> Changes in v3:
>  - Initialize resp_buftype to CIFS_NO_BUFFER instead of to -1.
>    Thanks to Ronnie Sahlberg for pointing this out.
>
> Changes in v2:
>  - Fix Coverity and Fixes tag.
>  - Update commit log.
>
>  fs/cifs/smb2ops.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
> index c6c6450d..8472cb0 100644
> --- a/fs/cifs/smb2ops.c
> +++ b/fs/cifs/smb2ops.c
> @@ -1133,7 +1133,7 @@ smb2_ioctl_query_info(const unsigned int xid,
>         struct smb_rqst rqst;
>         struct kvec iov[1];
>         struct kvec rsp_iov;
> -       int resp_buftype;
> +       int resp_buftype = CIFS_NO_BUFFER;
>         struct smb2_query_info_rsp *rsp = NULL;
>         void *buffer;
>
> --
> 2.7.4
>


-- 
Thanks,

Steve
