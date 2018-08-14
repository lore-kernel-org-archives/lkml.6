Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C124C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 12:49:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CFA821738
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 12:49:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O8PdB59l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CFA821738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732424AbeHNPgg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 11:36:36 -0400
Received: from mail-ed1-f44.google.com ([209.85.208.44]:34468 "EHLO
        mail-ed1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731724AbeHNPgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 11:36:36 -0400
Received: by mail-ed1-f44.google.com with SMTP id h1-v6so10050720eds.1;
        Tue, 14 Aug 2018 05:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=AijADzA106q3s+SGrEbKsbxoAfdYy1leFjKSYbsmxsA=;
        b=O8PdB59lu+7tENbNL5oODYBkZV9BEXor1aVLtVWCxT0ZvJSHL+/cB9h8pilkC/rOh0
         uocxTECtBEPpKGlSsQ2I8lIVS4xwHJv23WCjjKTBgk83xrthr972Oiy+OfEFH/VFzTY/
         1B+Lbw8YXBPEPWH70rYjAxaqWqsbhZuf0arke7kercbXJQ4s3FDumSTCVPB32uQjm80l
         8AgAw6DmgadF20X1LXcTxu9T7JlqlkLbp05Ih5OWlCXSF7GdhO6/q0VHnVj9Cgutnw19
         oNL8YJXMT9kfinnUKxswlrrM22tB5FKC5oV3S2qvkxbx2ZsemS0nuxrn0sR21dNkm2j2
         elTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=AijADzA106q3s+SGrEbKsbxoAfdYy1leFjKSYbsmxsA=;
        b=ZFjr78mzBrmNZS89js7tZOWE4ng652SD9GFJtQ2ueKL0UPHBd4ND2ZCiwhSrJWhqKw
         mTkO650uxvZOTQAR307JwQealxO0ps14nncO/R9hBJS5Fe2CfnzXO6lM/enmf8LDHat3
         exvZcMIT3HNTT2QCbx2QcY0cj51lASU7HIl7MaYmdoHjLo3zz63VyViTXgBrfK8LaBoH
         melN84Y3qL5AVg1xm3kAlQxAYyUosaSk1VeFyqK4t3C2ZFiNI1GnVlmcnXwO1EViRsSB
         nrYkeXtvA3JBWGNIMcGS7p07HHB4bMfPgNKYS7fz5B8obKM1O8AyEvbF9IhbDjwqweUY
         ycEw==
X-Gm-Message-State: AOUpUlFK+X0P1L5/qUe8Bi0lZ4NP4AHGJJuN9xvW8gwC0rtXFzZ/nyg8
        4qj2+Zt7T3LLBMu1ub7N3Z4UyJV4Hm6WO+NWeo4=
X-Google-Smtp-Source: AA+uWPxkgERPu5FwZ758CEtW902Do1avlw24iMEgOFsnuPGAgQjvVQNM9Trsi7/gmDoXVj0vjvBgcHEV2QgE3oGwCtE=
X-Received: by 2002:a50:9b5d:: with SMTP id a29-v6mr26978793edj.167.1534250972317;
 Tue, 14 Aug 2018 05:49:32 -0700 (PDT)
MIME-Version: 1.0
From:   Ramon Fried <ramon.fried@gmail.com>
Date:   Tue, 14 Aug 2018 13:49:20 +0100
Message-ID: <CA+Kvs9kZKt0tvsB-YqomM7grvRyDr=B-HPWUNv1ZcKi8w9ms-A@mail.gmail.com>
Subject: PCI Endpoint - Missing inbound mapping ops ?
To:     kishon@ti.com, lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.
I recently saw that the PCI endpoint API only supports outbound memory
mapping: (AXI -> PCI) through the map_addr op.
Why inbound mapping is missing (PCI->AXI) is missing ?
In almost all of the PCI EP controllers I've worked with there was a
need to map complete BARS or part of BARS to mmio/aperature regions on
the device.

Thanks !
Ramon.
