Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 958F6C04EBA
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 09:06:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A7B520861
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 09:06:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A7B520861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408777AbeKWTtf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 14:49:35 -0500
Received: from mout.gmx.net ([212.227.15.18]:37307 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732135AbeKWTtf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 14:49:35 -0500
Received: from localhost.localdomain ([149.172.187.38]) by mail.gmx.com
 (mrgmx003 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0Lmqxo-1fnVrf3pKG-00h2KN; Fri, 23 Nov 2018 10:06:08 +0100
Subject: Re: [for-next][PATCH 08/18] parisc: function_graph: Simplify with
 function_graph_entry()
To:     Sasha Levin <sashal@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        linux-parisc@vger.kernel.org, stable@kernel.org,
        stable@vger.kernel.org
References: <20181122003332.500796758@goodmis.org>
 <20181123073033.2083020863@mail.kernel.org>
From:   Helge Deller <deller@gmx.de>
Message-ID: <511cb47a-a1bd-bb5d-69ec-0836c6b5abfe@gmx.de>
Date:   Fri, 23 Nov 2018 10:06:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181123073033.2083020863@mail.kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:S5n0f4jPs+sTNMx81rph8begVVwghJxMZmwZUlqVgjlQn3ePt+A
 c08F8fO/oS3xCCbMFBInbw0e6WkPr6m6U4CotbfYtlxVKH/QYKjnqzJPDvW2wgU9uXufd7d
 l5CNkRfZI4rbhgSfqDJSyBgJBkjnOKFdCTOECEP7FPU8PcpZm4tOCT0VE7QMVY7dJ6apXaz
 JsgIQII65NTIDnsSu1pJg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6ClweRk3gqQ=:/gLLtybvOioP7YT0U8EIwF
 XUqAsjYRYWkBn6h6ORu2vwdHbviAQiY8xdJs1Vgyuzd6jJlTK6vJ33kf0MyOoRzOKqofnKSJr
 pESMu3gfbdY53UiA3cCh2SArHhHz2njm2KoUzLzDzLPNoPjm5O7m112g78g6ETblZtIy8Of7n
 gp5Og3T0N9VZv8hp4N+bmCOB8xceLld6owS8rKuOd3q7LqEwegOYpNA7vwGH1n8CzTIDDHNyl
 AnJdJzqiauFqar6PHlWsT4UOTOcJy9eI708RsT1ORQ8HIWmO20UyayVtkz4VfcAuRGVTvS1oc
 bf4z4n72y4A2GoShm/mvJMS8xKnlHkYmeTPGE3IYKWllfvWD9rXF60uxY/4hnlLJOEJ8o3j0d
 Up/Rw3xZnchePZtm7EBSSLH/Li6YVyxYZIMyQ/uP88zNpJcWiKyGQ/+LekvHgwYDD9UYbHF+T
 /VEuBTjFbmmwrz8Fb8DG1HyTh3tBEY03a/0Lc/fZPFSVyubz40Ur+i8wE3P51mwRFJk8aXrPf
 vHAClUS5JzfJ0h3LIwwOio+cEJ+p1Lc5hos7Siwy7N1WKqbMaVNIugxkOW7Eh/ZuIootcBlI9
 hgciF5YGfHPfuSfU/ONKWMoBWVjgecAFi3f/3PeIP0gMZOcIPIyJ1O9GljXsiN08az/5uxY/A
 ZWwDoWczjvHNyTu1rafDFvCRb4ds/l7G6GE+mGXcRxfrH48kBkwavqoxzz3sVNd4EsS2s2FbC
 Mj9bKLTcNzK24mtosyQ+ZbVu4doT3x6/JCarN99JGRBOwamqH+wIp1qg5DSj4i6v04ARkNYLu
 PqFXhT/01zZWFX4zW6EiiGP6ut3hhDb/rSK5HEg3pRPlSEm6rGWHR0TRQ9xMp4pO22bSRgWnI
 rJuh8XLcM6/GM1XbmMYFH7Eke0MOc1qNyoWV4wA0GekUiVqXIXqL97j/Ul6TgSFulBQxOecEO
 5NhscHB/mSHdNOMx4cSSH5J96lpsidsUpUmFrlnpE/qMV9r8ZfvuQH8Q/RGkRJGwio/GNAOk1
 ZQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI Sasha,

On 23.11.18 08:30, Sasha Levin wrote:
> This commit has been processed because it contains a "Fixes:" tag,
> fixing commit: 03274a3ffb44 tracing/fgraph: Adjust fgraph depth before calling trace return callback.
> 
> The bot has tested the following trees: v4.19.3, v4.14.82, v4.9.138, v4.4.164, v3.18.126.
> 
> v4.19.3: Build OK!
> v4.14.82: Build OK!
> v4.9.138: Build OK!
> v4.4.164: Failed to apply! Possible dependencies:
>      Unable to calculate
> 
> v3.18.126: Failed to apply! Possible dependencies:
>      Unable to calculate
> 
> How should we proceed with this patch?

My suggestion, although I didn't looked too much on it:
Apply it to v4.9 and higher only.
I think I started fixing trace functionality on parisc around 4.6,
which is probably why applying it fails on v4.4 and v3.x

Helge
