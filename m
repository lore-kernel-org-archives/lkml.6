Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A879C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 06:32:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51FCA20832
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 06:32:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f3K2Zyfy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51FCA20832
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727547AbeK1RdL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 12:33:11 -0500
Received: from mail-oi1-f179.google.com ([209.85.167.179]:40778 "EHLO
        mail-oi1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726972AbeK1RdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 12:33:11 -0500
Received: by mail-oi1-f179.google.com with SMTP id t204so21646071oie.7
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 22:32:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=LkQbJhcEoQSy97O815vZAu/hkBv3aSBNP4afYn4tHXE=;
        b=f3K2Zyfyoq4Y96ACxI1VB6uF734Nd1n1mbf2oL5xlZeJv7+0IASxWmnqUKFzuf1M+G
         V0l12q3x40DwjH373Hx4QEcNPp3QQl8Huvj0bKSJs1U0nMBJ+vIwK05ZUuOTeE5m8P1i
         FtbVkxOXDGpAX0as1NnvKyjcZxFNovtyOOeKmZMWhTt1QZWhcJQ+Bsde3RSSuMvzKkuu
         T7QsXToC6uf+7qP26rKzFZIy5UO8caWpnFKZjIpihf1LwQgl/sE7wqQ+VcVMCNWBlQxU
         7DgW5ocZNGy3Gi0P+u77KKMchym2sX4jvvMKe9YpIwZBzgmYnwNQOnQOmxBPe3GM5cxn
         T4xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=LkQbJhcEoQSy97O815vZAu/hkBv3aSBNP4afYn4tHXE=;
        b=bC2q3NkqgWd89bB22e9eT96kJ7vuhcb7MiZ7uMJ2lk8BnXwwpNZJelAQ/yegvMh8pv
         c+FQALqJD8IN0Ob3Kp8NokrMz2dhSA5mO1BszzgRoFc3S0n+WwfNlG1wXbyBhRAh97Ec
         mv/cbS6qC7PnFO5RXaqH52emIV+8KzuJfRrSlK1HVO2ekZ7tC4TDOIZOoqDl2HBTMnst
         lKc7PNeucltfyODUK3K/Bh9RsaxCxQTDquaqI6NHXFqhOUuK6hNckPMOSZLE7rEMz34r
         VUqP4nbwWcIpPaof23U4cx/9YFl9QZueLLHZ6IbmPrXLl1HG7FGkGcT2zDlNVxK5s/N0
         A2yQ==
X-Gm-Message-State: AA+aEWbMzPzl7MU3R6OiVEtTE8pUrj4Xra5ZGwVzCMbdy98vStYLYrEb
        4PGTUlq+zzFyiGiq48VhJQ+/gqpNDVwv0vNeCMo=
X-Google-Smtp-Source: AFSGD/X7835o0eGjpY5dE8TShgWWHduNJAUGoT9Shpc0797bfs7ouQ5VYXISz8unBBDhGE79S2cBc8fam5okgMGkEN0=
X-Received: by 2002:a54:4d8e:: with SMTP id y14mr20008034oix.60.1543386758539;
 Tue, 27 Nov 2018 22:32:38 -0800 (PST)
MIME-Version: 1.0
From:   David CARLIER <devnexen@gmail.com>
Date:   Wed, 28 Nov 2018 06:32:27 +0000
Message-ID: <CA+XhMqyP1=WCDGJXbLCpz44fKs0gWbc7a0Bfw2M815mSt4fAxA@mail.gmail.com>
Subject: Re: [PATCH] Little memset_explicit optimisation
To:     alexander.shishkin@linux.intel.com,
        Joey Pabalinas <joeypabalinas@gmail.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bad entrance with bad idea I m afraid :-) sorry for the noise.
