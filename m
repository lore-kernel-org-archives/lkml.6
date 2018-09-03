Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBD07C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 08:32:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FA5420843
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 08:32:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OGFGETMI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FA5420843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbeICMvN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 08:51:13 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:36041 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726961AbeICMvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 08:51:13 -0400
Received: by mail-qk1-f194.google.com with SMTP id 93-v6so5160922qks.3;
        Mon, 03 Sep 2018 01:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=+9chU9q1oG/JYpCVufS+m9SpDSPNFBo0ybiGjUZqGcE=;
        b=OGFGETMIXyRoVLVzPLmHq3iiXqHIaukMhCF1xMZfy4ZJOmss+Zyg4SdGDUm9HuO34q
         SCxZwiNYKpfnw809s2bQbIqRCJUYKGgIuA3Ws5AQLpBELoJxgKLx5xcSRZF1fqnJHu52
         5ijQDECw6hh6R8TMkqarNUWJVS4bu+VEpO8hfnyfL+QLAqZsgDNIglMLq4cbmP1DEf1T
         JgOlHIh49zoJnuy1ZndWlEPy+Kuka3k5y66pKGhLWJtAU1FQwuiTzT51KyLal0aogdks
         mlwOvmrRvfi1Gzub1acAhad7Hvhs1ImcX2xL/5iVMux/3MlgXfSAL9ASyJUjlCB1Gwu/
         s5FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=+9chU9q1oG/JYpCVufS+m9SpDSPNFBo0ybiGjUZqGcE=;
        b=ICdxpEManxzRxYvmLY3rRR7bIJhQFCAFbF6GcPwJpYOEmy9QMZnJOQOMQ3d9vjhfXI
         wBJv8aZm+MkE9veeuVhSpwrZ6RjF1tBIVXFdlnCn+fm6XDl35WpOg5I5OLIDRHt1V90y
         ZCODKBnT0EcTz3lXK3y/9ujiMxAajvd2n0DLBPCjxf3WB68Jz9hqQGOrnvSKN9FqYJKh
         XRbxElBSrxFlJ4HoWKpH/H9MGceKQqrZ7F4AiefZkZqPsS9faaD9+7l3ehy0qPmWycO7
         w6s9/5f2Dg5WsqTYQ9MHZ0DgaYZtAgXBMmM/hDN8kw+ynmswcfwWH9ILas5H8zB5bOIu
         MyoA==
X-Gm-Message-State: APzg51A1JTQGGxshSYdeAbxzSEw9XikzKzUmPagg5HxOj61hbIO2mGul
        P3KMwTg2JvJAl5AD/7mFCXT5jD5KGwAw2119bQuic1ux
X-Google-Smtp-Source: ANB0Vda+M5sA4FZ1xnCuQknQoiqfBwF+D8IheZnLuq0F2ySiijTpSOa5cGmExHN7BVCzw0ysEstKRjyySvcW4lIVnoE=
X-Received: by 2002:a37:9306:: with SMTP id v6-v6mr23665871qkd.36.1535963528082;
 Mon, 03 Sep 2018 01:32:08 -0700 (PDT)
MIME-Version: 1.0
From:   Xiongwei Song <sxwjean@gmail.com>
Date:   Mon, 3 Sep 2018 16:31:56 +0800
Message-ID: <CAEVVKH9sq9oMX0hVen9sX+9GoG=4Y8v7RPMBD_iuZOe9Mgiw1g@mail.gmail.com>
Subject: Question about pe file verification
To:     dhowells@redhat.com, herbert@gondor.apana.org.au,
        davem@davemloft.net
Cc:     keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Some code logic I don't understand about the function pefile_digest_pe_cont=
ents
 in the file crypto/asymmetric_keys/verify_pefile.c.
At the end of pefile_digest_pe_contents, please see the comment [sxw] below=
:

static int pefile_digest_pe_contents(const void *pebuf, unsigned int pelen,
                     struct pefile_context *ctx,
                     struct shash_desc *desc)
{
    unsigned *canon, tmp, loop, i, hashed_bytes;
    int ret;

    ......
=E3=80=80[sxw] I assume the image has signed by sbsign tool, there is a cer=
tificate
             at the end of image file.
    if (pelen > hashed_bytes) {
        tmp =3D hashed_bytes + ctx->certs_size;
        [sxw] The tmp value is the end of certificate.

        ret =3D crypto_shash_update(desc,
                      pebuf + hashed_bytes,
                      [sxw] The data address is the beginning of the
certificate.
                               Why do we need to hash the
certification data block?

                      pelen - tmp);
                      [sxw] However, the data length doesn't include
the certificate,
                               sometimes it's zero.

        if (ret < 0)
            return ret;
    }

    return 0;
}

Is that for a special consider or something else?

Regards,
Xiongwei
