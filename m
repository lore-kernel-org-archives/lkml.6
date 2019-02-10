Return-Path: <SRS0=kemo=QR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47AE9C282C2
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 19:23:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 116ED2146F
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 19:23:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CAI+3Nmr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbfBJTXT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 14:23:19 -0500
Received: from mail-qk1-f170.google.com ([209.85.222.170]:34977 "EHLO
        mail-qk1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbfBJTXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 14:23:18 -0500
Received: by mail-qk1-f170.google.com with SMTP id w204so5267448qka.2;
        Sun, 10 Feb 2019 11:23:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=2fbE5WAXjNZWSpDLSLNpKZwdw5lQJeAWG6NbpXX+ob8=;
        b=CAI+3NmrTZAUYQMtVTzbWvTWak2GXP/54xPJwPxVaEXbAQ9t+4PWJVkxK+ZhGNeL4/
         fNsNH1RRfZUZ4qDCtXdPotA3jpq0XFzmnlzQDM9lJXkMZCH2qbLEY125/UA2vgcuQSNN
         wT4vXPr95qHmrqhJKKKQl36WNr/EuFM3c4Ij+TEOF1csXo4YUf2UtDj1qtu86QVIwuy9
         hF6T5xgM02puPt4uknWtDQU+MOk15GS/EDdllnFRhB/Yoke/euZBU0pwI3RN/JvTOzCN
         9d7H4y7fJB1QLYLLmApB4oVYlATShFhTYW1NSl2vAgRXjbBwod9gA0mIhKX9lweL838q
         BfyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=2fbE5WAXjNZWSpDLSLNpKZwdw5lQJeAWG6NbpXX+ob8=;
        b=kiim5qHTdy7qewhh5oosOjFwyijM4a1daODE62mNDSfVletQsoY5ys4evV4p+PvT4p
         WCn9LbJsV2KQDJ0ejji4lz4G9FXEYBEIThq4MY/WnMN/dltH2fZ7OD0S8HvNbh3YNBPh
         YhdcDvFoU4kXJBL75U4CJGCxSTTldNJRv9GWxpSgfsZ7fjSHbm13/msage3E4WgCDqkU
         4aolu5g5Z9xtP0fJgsjOVpeEsCfBCYIYR8HJ7k8cGf/jhVcaTMf7Aqi1/AU+17T9o4Ea
         3uFSijuQBPNYote+YAIzbyC3lxymAbWHzTGSoTqHX0SUEIlTrK1RJoUfW54clOeF2JJj
         mhfw==
X-Gm-Message-State: AHQUAubilDpwgGUoer3fDAtf4yjaUq0QBhKlUUxd0t5xV0hhzox1AH+R
        yOYj6zos2vcDfiC+z1463eioE4/liHQ=
X-Google-Smtp-Source: AHgI3Ibkg5cWuiQSvaAhvc6jRsguoQoO22eMS/4M+TaaokWJNNX0+K2ULIztLOPYaxfOQ9/6vYxE5w==
X-Received: by 2002:a37:7d05:: with SMTP id y5mr22076500qkc.310.1549826597254;
        Sun, 10 Feb 2019 11:23:17 -0800 (PST)
Received: from bebop (189.26.177.147.dynamic.adsl.gvt.net.br. [189.26.177.147])
        by smtp.gmail.com with ESMTPSA id o21sm10586687qto.18.2019.02.10.11.23.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 10 Feb 2019 11:23:16 -0800 (PST)
Date:   Sun, 10 Feb 2019 17:24:14 -0200
From:   Marcos Paulo de Souza <marcos.souza.org@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     jprvita@endlessm.com, andriy.shevchenko@linux.intel.com,
        platform-driver-x86@vger.kernel.org
Subject: X450LCP lost abillity to turn the screen off
Message-ID: <20190210192408.GA81989@bebop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Since 5.0.0-rc4 I vefiried that my ASUS laptop cannot turn the screen of
anymore. There were several commits in 5.0 merge window touching this
functionality like:

  71b12beaf12f platform/x86: asus-nb-wmi: Drop mapping of 0x33 and 0x34 scan codes
  b3f2f3799a97 platform/x86: asus-nb-wmi: Map 0x35 to KEY_SCREENLOCK
  78f3ac76d9e5 platform/x86: asus-wmi: Tell the EC the OS will handle the display off hotkey

I didn't have time to track it down, and my previous working kernel was 4.12
(default in openSUSE Leap 15), but I hope I will be able to test older kernels this week.

-- 
Thanks,
Marcos
