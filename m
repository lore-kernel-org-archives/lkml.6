Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B3FCECE562
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 09:28:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1D912083A
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 09:28:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zr1D2uns"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1D912083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbeIOOql (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 10:46:41 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40095 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbeIOOqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 10:46:40 -0400
Received: by mail-pl1-f196.google.com with SMTP id s17-v6so5249590plp.7;
        Sat, 15 Sep 2018 02:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cbG9GENJ1mKMxn+VZVme4FL5C8by4y5F9A4vW44UKsI=;
        b=Zr1D2unsuUeTqpFHs6b9WW4FHyXwTmks/P+efUJxuN1WAeE41PfmX+ReBXEYF7p2O1
         pnMHoQrRStX43bCLsjFZRRQPQS3NXcMc+dOnlQ1UlahWD/nMoGGonsLuo9Neql4OMPXi
         8wfcyyq73RTzJPNC/OTA7Sk1/mIKmH6MPxLvnezJehNPTqPmsas18ms+/FtXQ5jljrED
         KLWAhlkHVW9SsLBhAGz36KP3VHAYXbFmWEIENNqhD1E7+k/LOZAan000p6HwhF0BXwCX
         UUtn5FqNQcjCP+1DJjvchUKV3lY9eCL9G45Ln+RfcSotqmyk+12IRIc9JM0kyAMFV9ne
         3dvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cbG9GENJ1mKMxn+VZVme4FL5C8by4y5F9A4vW44UKsI=;
        b=ND5DIFSdlLPhPaRYygn2qzk6zqHp9kao0e8lu+v82zgvZDVZv30m1cqjD9JjMdiIrP
         EzwdEkDzGi1Us1NuQeArZd8njRIuhOmo8LzlUx57tBOhzkfC+QcWLgRYtF8zusut19V7
         Ky1O8s7sorYPUxirpWN++h1qtJBrGNX2yaj1OlZR8RUqFm7y5NQCectO9YD1fiFd/pU9
         RvIL4kTZuuIjAjadkzTds4IJRGVhopyDBlhCXIFguRb4hZrYBiywjVXimEpp1sZGuXws
         vvZh7HmnRAl6aYWkkfylrKshcuuaJEkc50k5/4ZMlT/uwLfI1i3HlfZPh/xTaN95AWwT
         HNXQ==
X-Gm-Message-State: APzg51CduMYjA6H3mUP2/EzMDnBB26+sUUc0KNIBzOWYpniqGkMke/E0
        hPREluunqQoIbva/grOIoZPyyHfr52+qy4LdDMI=
X-Google-Smtp-Source: ANB0VdYG/YwP/2x1IvxcHhgm0Dn/Aodbvw2MgOgV7XEKr47CcW1Bch3bjatKYUCFAl/wnoCmp0QMV9qYek2QdMPQFwo=
X-Received: by 2002:a17:902:e85:: with SMTP id 5-v6mr15534880plx.73.1537003700771;
 Sat, 15 Sep 2018 02:28:20 -0700 (PDT)
MIME-Version: 1.0
References: <20180908021348.19956-1-longli@linuxonhyperv.com>
In-Reply-To: <20180908021348.19956-1-longli@linuxonhyperv.com>
From:   Steve French <smfrench@gmail.com>
Date:   Sat, 15 Sep 2018 04:28:09 -0500
Message-ID: <CAH2r5mtaV-avzB0Ygb7CidVoWaSXQ_5E8F5Ed1RQAyGue43jcw@mail.gmail.com>
Subject: Re: [Patch v3 00/16] CIFS: add support for direct I/O
To:     Long Li <longli@microsoft.com>
Cc:     Steve French <sfrench@samba.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

could you rebase these, patch 1 was merged quite a while ago, and
patch 2 etc. doesn't apply cleanly
On Fri, Sep 7, 2018 at 9:18 PM Long Li <longli@linuxonhyperv.com> wrote:
>
> From: Long Li <longli@microsoft.com>
>
> This patch set implements direct I/O.
>
> In normal code path (even with cache=none), CIFS copies I/O data from
> user-space to kernel-space for security reasons of possible protocol
> required signing and encryption on user data.
>
> With this patch set, CIFS passes the I/O data directly from user-space
> buffer to the transport layer, when file system is mounted with
> "cache-none".
>
> Patch v2 addressed comments from Christoph Hellwig <hch@lst.de> and
> Tom Talpey <ttalpey@microsoft.com> to implement direct I/O for both
> socket and RDMA.
>
> Patch v3 added support for kernel AIO.
>
>
> Long Li (16):
>   CIFS: Add support for direct pages in rdata
>   CIFS: Use offset when reading pages
>   CIFS: Add support for direct pages in wdata
>   CIFS: pass page offset when issuing SMB write
>   CIFS: Calculate the correct request length based on page offset and
>     tail size
>   CIFS: Introduce helper function to get page offset and length in
>     smb_rqst
>   CIFS: When sending data on socket, pass the correct page offset
>   CIFS: SMBD: Support page offset in RDMA send
>   CIFS: SMBD: Support page offset in RDMA recv
>   CIFS: SMBD: Do not call ib_dereg_mr on invalidated memory registration
>   CIFS: SMBD: Support page offset in memory registration
>   CIFS: Pass page offset for calculating signature
>   CIFS: Pass page offset for encrypting
>   CIFS: Add support for direct I/O read
>   CIFS: Add support for direct I/O write
>   CIFS: Add direct I/O functions to file_operations
>
>  fs/cifs/cifsencrypt.c |   9 +-
>  fs/cifs/cifsfs.c      |  10 +-
>  fs/cifs/cifsfs.h      |   2 +
>  fs/cifs/cifsglob.h    |  11 +-
>  fs/cifs/cifsproto.h   |   9 +-
>  fs/cifs/cifssmb.c     |  19 +-
>  fs/cifs/connect.c     |   5 +-
>  fs/cifs/file.c        | 477 ++++++++++++++++++++++++++++++++++++++++++--------
>  fs/cifs/misc.c        |  17 ++
>  fs/cifs/smb2ops.c     |  22 ++-
>  fs/cifs/smb2pdu.c     |  20 ++-
>  fs/cifs/smbdirect.c   | 156 ++++++++++-------
>  fs/cifs/smbdirect.h   |   2 +-
>  fs/cifs/transport.c   |  34 ++--
>  14 files changed, 606 insertions(+), 187 deletions(-)
>
> --
> 2.7.4
>


-- 
Thanks,

Steve
