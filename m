Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D2C3C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 16:21:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00D3D2084C
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 16:21:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725885AbfALQVs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 11:21:48 -0500
Received: from mout.gmx.net ([212.227.17.20]:54309 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725847AbfALQVr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 11:21:47 -0500
Received: from longitude ([109.90.232.48]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Lusmr-1hQrxH3aUb-0101Mb; Sat, 12
 Jan 2019 17:21:34 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Subject: [PATCH 0/2] powerpc: wii.dts: GPIO interrupt and button support
Date:   Sat, 12 Jan 2019 17:21:22 +0100
Message-Id: <20190112162124.3341-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:NvSI0Cn9AkS944gBf8AO4c2SIPinsXmyo1eQWzZU5kvzefHaxLa
 TbSLldJGLjkVAvigiWClgZRNcwwtP0+RAzeXQlMa9s8S/i1MylnKghvWYCP6hMh/7ZZtO7Q
 7IkF3TIyO4OJdKqSMeqpPZQRS91MlbZwHy4ejqbQaq/sKvkutDB/Kd1C2TjVDQm08Q7kouG
 3Ya53DmxFA9u6KfZMCg1g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jOg28cehjJc=:U6S+rokhk2RJ3Aw9zSPSXM
 S8x7z7p706FrmRUdWwVHP6rDUd+o7cvrlVwddSwWlrKl4Bpu0U7o7LFg8/Ogr9FGZLPvystln
 ljYjQK7cMQuMtT2OFwD4qQCGsed29Dtfw4eb+mdkfUjk1YJnbHrPnUFJPooZ1pMJz4EgrYV+M
 mYvNmULcT8Ulp6+tdC3MJwYBf+kti4Zf1OZTWkzKCdKKBVYqFf2g9srgEKiHpCcHb+1uTVjvO
 WF1p93PQK/zF/YiDD/H6ZuAgQvDagGn4oHEkH9XUY5Bv1SvAhuiomkFc5HX4e0wXduEEE7lI5
 hJpyZzlld7sCZ6ilxpkJND7mgriQewdl9HknEXyM5NHgrKl1ewt2U0YOuFqyavYOCZjSHsL3+
 VQJclMJ+xeb85zZE795ufTcdW2AtI3OsY7DHHme9rUEB2Q8BjNf7OeEpnfW5iafD3ndKuhnXX
 innExc/sJ5AR4fZfV0sBV5fWR5h6Mvll67gEgcM3sUzSMSuCVUAXSp/mGDj5MkF6DrnHCFmVD
 mYrxWyXefKKLHNYjIYne/SmBZv7RYph0VESsG/fdEFKJm74aPAYksU1pBvd8NBxCNcgUfXPUn
 QeklNZjqZNrHA0i+LjaaLAiDZDIQYtakl6f010jB6XTE2e8OQQwSfE4fUcdp4KGo+jBGM2yL9
 PHLDLkfAc4MbxHh8Fi8a8pCIfyv1lpIOLqDnV1R8lJjfTeqaTGB7AaGk0ITd4h19nwhnEgc3K
 dSqO91fhduCYRi6+cAOc070MuWJLRVhYsb5Uua7tUjNc3+viTRUWgumPiFnlGOTXUC8IHx6b5
 8DIQZFZSdLn/gcpoG9up49yDmiVjRr2UZTfphd0QgR75YX5fId9IUtLA8xo4sF4czd5o8nAdX
 7yJRWR3gojgyEgzssNhnCX5e/W7PdLpDFwwxTz6r3MNl40lap2CGfJ4jzUAqPGlCS//2Dwwjl
 lor1L2KlSkA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds the necessary bits to wii.dts to enable interrupt
support in the GPIO controller, and defines two GPIO-based buttons,
the POWER button and the EJECT button.

I will send another patchset which will implement interrupt support in
the GPIO driver (gpio-hlwd.c).

Jonathan Neuschäfer (2):
  powerpc: wii.dts: Add interrupt-related properties to GPIO node
  powerpc: wii.dts: Add GPIO keys

 arch/powerpc/boot/dts/wii.dts | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

-- 
2.20.1

