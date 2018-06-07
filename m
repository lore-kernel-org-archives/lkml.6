Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id LwvVC4JcGVv+JAAAmS7hNA
	; Thu, 07 Jun 2018 16:26:03 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 1D4DE607E7; Thu,  7 Jun 2018 16:26:03 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TqnEOFaj"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_MED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 86CE2601B4;
	Thu,  7 Jun 2018 16:26:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 86CE2601B4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753813AbeFGQ0A (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 12:26:00 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:33739 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753153AbeFGQZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 12:25:57 -0400
Received: by mail-pl0-f65.google.com with SMTP id n10-v6so6459533plp.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 09:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=cDSNmIJhN3A7cQAcb8/tQe8fQUUXQbuyhAZjLmwUn1o=;
        b=TqnEOFajvXYtb3CsGqpcloXrrayjtEUQmZxNlW1zi3nMikWDh0cG9g928wvN+9Ff57
         LH1pParaCyjZ1befHiR/pPqeJ2Ugmc7ytmPxrqaK1bC8u8OZGROfhCfEsfG+sFI7vx8+
         5DH8F/WDX4IMLaFvKh1MB68J2GE0/5y0VTCMCH+tATSyJpZ9DwgpiNsYru1n3+H0sjsE
         nbOvy/Goh7FTGcm+eE990iy8DkAF6LrHQF3DynJkhg+4YpAkHNCYSCy084bvWsv+MxlD
         5pRuMVqDCLnlcflFF90p4nZQDo8cePNVZfF0B58X0L4LoFoPZ/phrpdyGz3vNultDoGt
         gycA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=cDSNmIJhN3A7cQAcb8/tQe8fQUUXQbuyhAZjLmwUn1o=;
        b=iyLMVC8AnF102SiAfSdEPY99OxnMMeqg8Tcu20XajzOb0rHWiiNtaYqC5xqdgt4QA2
         v/BJwr1xYXBs+7j+BnhU2vl7HMsOVYajqN+dApkFDiXDduY6/TLry/rMaW+AOTadHqIC
         wRTLZx6TSY+StNvkL4bdabOJDRwgAXlgZAliayAPCBOwxiDm99ODMngMdy50l4rjQ/5+
         T9Mj6MWUc6d/xClViUz3aTMCujg2CpKsSVswI6hvHXcYYiPieyJFTY0YHXJxrYb4I4S9
         CCg5MysK//NfY1lsbfqj/lLIkK4uOhNSC2wSl+Mf/QdFSemAl3NIDdPuutwoFP4IKoZ9
         yXrw==
X-Gm-Message-State: APt69E3h84E+v0DVrfCnx2qol2ffwNyI0uj3/j8JqO7cZ8VKYHC2B0n3
        UqXoZnKYYxKUUj45s0dVd5Z924Lg6xcJnx3MxUf6ow==
X-Google-Smtp-Source: ADUXVKID3uaRz4AhkqEgyRbx/4BxF69FJ7eb99e15r5zgRNC+mxw8xq6Zy+51kVsz5hhUdOzC/BvJ/ZSXUOe6cM81po=
X-Received: by 2002:a17:902:264:: with SMTP id 91-v6mr2676360plc.341.1528388756451;
 Thu, 07 Jun 2018 09:25:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:d42:0:0:0:0 with HTTP; Thu, 7 Jun 2018 09:25:35
 -0700 (PDT)
In-Reply-To: <20180607183627-mutt-send-email-mst@kernel.org>
References: <000000000000a5b2b1056a86e98c@google.com> <000000000000cf4578056ab12452@google.com>
 <20180607183627-mutt-send-email-mst@kernel.org>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Thu, 7 Jun 2018 18:25:35 +0200
Message-ID: <CACT4Y+btyLi+z09EO0JU-7AS_OfRbWiZvGn-KP9fndevh+xFNw@mail.gmail.com>
Subject: Re: KMSAN: uninit-value in _copy_to_iter (2)
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: syzbot <syzbot+87cfa083e727a224754b@syzkaller.appspotmail.com>,
        avagin <avagin@openvz.org>, David Miller <davem@davemloft.net>,
        Ding Tianhong <dingtianhong@huawei.com>,
        Eric Dumazet <edumazet@google.com>,
        "Reshetova, Elena" <elena.reshetova@intel.com>,
        Jason Wang <jasowang@redhat.com>,
        KVM list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Matthew Dawson <matthew@mjdsystems.ca>,
        Ingo Molnar <mingo@kernel.org>,
        netdev <netdev@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        virtualization@lists.linux-foundation.org,
        Willem de Bruijn <willemb@google.com>
Content-Type: multipart/mixed; boundary="000000000000e8e79a056e0fbcf6"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000e8e79a056e0fbcf6
Content-Type: text/plain; charset="UTF-8"

On Thu, Jun 7, 2018 at 5:38 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> #syz test: https://github.com/google/kmsan.git/master d2d741e5d1898dfde1a75ea3d29a9a3e2edf0617

Hi Michael,

We need:

#syz test: https://github.com/google/kmsan.git master

here. Please see
https://github.com/google/syzkaller/blob/master/docs/syzbot.md#testing-patches
for more info.

Please also add the Reported-by tag when mailing the patch for review.

Thanks

> Subject: vhost: fix info leak
>
> Fixes: CVE-2018-1118
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index f0be5f35ab28..9beefa6ed1ce 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -2345,6 +2345,9 @@ struct vhost_msg_node *vhost_new_msg(struct vhost_virtqueue *vq, int type)
>         struct vhost_msg_node *node = kmalloc(sizeof *node, GFP_KERNEL);
>         if (!node)
>                 return NULL;
> +
> +       /* Make sure all padding within the structure is initialized. */
> +       memset(&node->msg, 0, sizeof node->msg);
>         node->vq = vq;
>         node->msg.type = type;
>         return node;
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/20180607183627-mutt-send-email-mst%40kernel.org.
> For more options, visit https://groups.google.com/d/optout.

--000000000000e8e79a056e0fbcf6
Content-Type: application/octet-stream; name=patch
Content-Disposition: attachment; filename=patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ji4r5e8p0

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmhvc3Qvdmhvc3QuYyBiL2RyaXZlcnMvdmhvc3Qvdmhvc3Qu
YwppbmRleCBmMGJlNWYzNWFiMjguLjliZWVmYTZlZDFjZSAxMDA2NDQKLS0tIGEvZHJpdmVycy92
aG9zdC92aG9zdC5jCisrKyBiL2RyaXZlcnMvdmhvc3Qvdmhvc3QuYwpAQCAtMjM0NSw2ICsyMzQ1
LDkgQEAgc3RydWN0IHZob3N0X21zZ19ub2RlICp2aG9zdF9uZXdfbXNnKHN0cnVjdCB2aG9zdF92
aXJ0cXVldWUgKnZxLCBpbnQgdHlwZSkKIAlzdHJ1Y3Qgdmhvc3RfbXNnX25vZGUgKm5vZGUgPSBr
bWFsbG9jKHNpemVvZiAqbm9kZSwgR0ZQX0tFUk5FTCk7CiAJaWYgKCFub2RlKQogCQlyZXR1cm4g
TlVMTDsKKworCS8qIE1ha2Ugc3VyZSBhbGwgcGFkZGluZyB3aXRoaW4gdGhlIHN0cnVjdHVyZSBp
cyBpbml0aWFsaXplZC4gKi8KKwltZW1zZXQoJm5vZGUtPm1zZywgMCwgc2l6ZW9mIG5vZGUtPm1z
Zyk7CiAJbm9kZS0+dnEgPSB2cTsKIAlub2RlLT5tc2cudHlwZSA9IHR5cGU7CiAJcmV0dXJuIG5v
ZGU7Cgo=
--000000000000e8e79a056e0fbcf6--
