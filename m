Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7514BC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:04:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38C3C21741
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:04:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hjb+GqeQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387486AbfA1QNs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:13:48 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38018 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731477AbfA1QNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:13:46 -0500
Received: by mail-wm1-f68.google.com with SMTP id m22so14599220wml.3;
        Mon, 28 Jan 2019 08:13:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=rxGIEOknPcIjzPkhfQGdQEUCzYEDmz6NxBwhd+7iTxg=;
        b=hjb+GqeQ0nKVYZZ20+EC1gArRGp2v7kwSVXbFjaj+Xi25lIpVWRvAZw6frB6KXMWd4
         auLte6qS+WTWa8ejnrWavK5wzdXBjk4mgpm2OVOXU6KrbnxdFu6bgGHlqcmwPnvQx/30
         XgLwM5TyFRDv2JEHFxICa1Q13mKObEvTOEZBoObSa/es8e6w2vjlTgpfocsPmjHweDLD
         aUQ8qraQ/Yr2tZSdzY5/cyrK1RQtoXBE1Bv0SOa6vpkSf0VCPVkVIyOpb36VH0nR2p4K
         GYhIrDmmCdegAoCVAhcHuApWq573Jp7+E/w1tDZVE8pWRUmvZGLnJUH0AsPv+aD2V2VR
         L3dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=rxGIEOknPcIjzPkhfQGdQEUCzYEDmz6NxBwhd+7iTxg=;
        b=ddS347Lw4e1GsW6DLTehGcX1DC0Nz3ng9EfZxB7+/jb9LBiACik1PvM5PVPAqx1Jnx
         tHO58PlmywxNBoEkzdAQw7KSebfdN5AJ44WLu2e6j5tTd40FeOEdMaYJuGDApIdUG0ut
         xP5pMaWdda07YrwT3ZN7Pmd29vYhCqzNXjzWGmApyxSmpuT/WcE6A3iir/ivnIkx1Iy4
         jD9YJ+4TBcLOZwt/BS1oYqoQEVFDlkOvlI3whB+j/5XC60g3/n9xmI7ScyDYBTcpqyon
         92fgDdF/xTjGIU5Hm6IXuyNNdcxdKaORRTJ+TtOd/yAogQjxqU9ygW26fFABUXRtADr7
         aOXw==
X-Gm-Message-State: AJcUukes/9p5LHjBzZG8PHko8iuxc1iv50Dw2Bj/5wslWUsZeWmfm8SE
        NLWiZDYGSBsbOiWTPjOfLBo=
X-Google-Smtp-Source: ALg8bN7DPSwnRrVo2SRzIEv9o+WafAVeE56vhdzmV00P8HSgnMXwxR9/Xty8z1jtC0YUtyeK0dbqow==
X-Received: by 2002:a1c:dc86:: with SMTP id t128mr18589508wmg.42.1548692024930;
        Mon, 28 Jan 2019 08:13:44 -0800 (PST)
Received: from Sarah.corp.lairdtech.com ([109.174.151.67])
        by smtp.gmail.com with ESMTPSA id l20sm246445944wrb.93.2019.01.28.08.13.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jan 2019 08:13:44 -0800 (PST)
From:   Ben Whitten <ben.whitten@gmail.com>
X-Google-Original-From: Ben Whitten <ben.whitten@lairdtech.com>
To:     afaerber@suse.de
Cc:     linux-lpwan@lists.infradead.org,
        Ben Whitten <ben.whitten@lairdtech.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH lora-next 00/11] net: lora: Get SX130x to transmit lora packets
Date:   Mon, 28 Jan 2019 16:12:54 +0000
Message-Id: <20190128161306.27805-1-ben.whitten@lairdtech.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This series adds setup nessesary to transmit lora packets from the
SX1301x, it builds on the comments on the RFC [1] to a point where
the card is capable of sending out a LoRa modulated signal using
transmission paramaters from the LORA socket address.

As patches have been refactored and split up extensivly to bite
sized chunks they do not include individual RFC -> v1, this is
covered in this letter.

The setup involves starting the firmware up inside the card by
providing a LUT of its internal gain values calibrated against
the card output. As this information is hardware specific it
is added as a binding in the DT, with documentation to match.
Binding patch is based off a commit of the basic documentation
under review [2]
Not captured here are commands to set this gain table for use
in devices which do not use DT.

As _stat_xmit cannot sleep we spin the tx function to a work queue
so we can write to the SPI backed regmaps.

As proposed [3] as one way of getting lora packet metadata to
the driver is by using the socket address to encode spreading
factor, coding rate, bandwidth etc. The corresponding translation
is added on the driver side, populating the test transmission with
real values and has been tested to show changing bandwidths.
To perform testing a tx_test [4] was used to show changing
parameters on a spectrum analyser.

We also add patches to the defaults in the SX130x to fill in a TODO
in our initialisation.

Thanks,
Ben Whitten

[1] http://lists.infradead.org/pipermail/linux-lpwan/2018-December/000019.html
[2] http://lists.infradead.org/pipermail/linux-lpwan/2019-January/000150.html
[3] https://events.linuxfoundation.org/wp-content/uploads/2017/12/ELCE2018_LoRa_final_Andreas-Farber.pdf slide 16
[4] https://github.com/BWhitten/lora-modules/blob/master/tx_test.c

RFC -> v1
* Split up commits to sensible order and logical block sizes.
* Added DT binding for TX gain LUT.
* Fixed spelling mistakes.
* Converted metadata enums to suggested integers with suitable sizes.
* Fixed out by 1 in test transmission population.

CC: linux-lpwan@lists.infradead.org
CC: netdev@vger.kernel.org
CC: linux-kernel@vger.kernel.org


Ben Whitten (11):
  dt-bindings: net: lora: sx130x: add power lut binding
  net: lora: sx130x: add loading of tx lut from DT
  net: lora: sx130x: add CHRS to volatile register list
  net: lora: sx130x: add helper function for writing to the SX130x MCU
  net: lora: sx130x: initialise AGC
  net: lora: sx130x: add detail to TODO in setup
  net: lora: sx130x: add work queue to tx path
  net: lora: sx130x: add test transmission
  net: lora: introduce lora socket addressing for metadata
  net: lora: sx130x: make use of lora address metadata in transmission
  net: lora: sx130x: add patch to register fields

 .../bindings/net/lora/semtech,sx130x.yaml     |  13 +
 drivers/net/lora/sx130x.c                     | 521 +++++++++++++++++-
 drivers/net/lora/sx130x.h                     |  97 ++++
 include/linux/lora/skb.h                      |   9 +
 include/uapi/linux/lora.h                     |  14 +
 net/lora/dgram.c                              |  45 ++
 6 files changed, 697 insertions(+), 2 deletions(-)

-- 
2.17.1

