Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47D92C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 16:57:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12964218EA
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 16:57:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jBjbkIcN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727409AbeLZQ5g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 11:57:36 -0500
Received: from mail-io1-f45.google.com ([209.85.166.45]:43952 "EHLO
        mail-io1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726985AbeLZQ5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 11:57:35 -0500
Received: by mail-io1-f45.google.com with SMTP id a2so874572ios.10;
        Wed, 26 Dec 2018 08:57:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WASiI+LGr+j54QgtHqz/Mb0c0vmWaC6GIOI+FQCQgEU=;
        b=jBjbkIcNRPTW3EKZ8swdKTB3oOOooU/FwdGKdVM/W0Kv+rhN+E69nn2gSSOwJpwGg9
         zCeRMKZ5YEKJqxLIboYkZnrkHPmU0I2t88/Lbf6ky2F8gDIhv/u6bXGyXC4yjgs+f08k
         uXk0P3HOwZNFO+vL/aE7X1WWHUxnWKP5ve4byvTo+ft64Y2TJN4wkPlv3lYkIcdvnDnK
         njulHfBRqYu+92uc6VbQeX4kxBD0u5RoC0C3/fyPHuOVTKpAYXwdutA10fIZo4DR3LT5
         WIRpQ0D+4GjMXbNwVeCrhRZvQBXqrb+pHn8SoKzux1DJm9asegbiKXbMBpCl9Uo/hXaq
         +DFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WASiI+LGr+j54QgtHqz/Mb0c0vmWaC6GIOI+FQCQgEU=;
        b=TTpnQ+YA/mhlh+T0elgDYFpDLYXPdP2MzZetApiwX441hhEjJj76OcavQtiq77qBg7
         6C2zW4WyDliV2uLys8YlqdQore5hg31ht/5QtmHhRZ69/nyG2CyVGl6DpiVM1qrXfDYT
         XgF/D5Qo0yrPU0/RuKFMewGR4UBgXUQC4IAnYaQkgUpCj1unYl0rRyzmTQAHi9uvm2VO
         h7oS5iGtwaQNUwx7y7/FTdZq6xBMxLktNrxBU76QqyTF/hVXQLuE6AegULLoB/lHUgrX
         hUSGw+vMZ2LIo3M7OtjF2D3Sp4hTcrgFXI83GoAdi5VLSTYXMH4rDmEsf9QXsCbRIP93
         1BLQ==
X-Gm-Message-State: AJcUukeaWj1pGNnQX5QFqBsHLcSG1mjKifMLDOjaT3CndAdLChzjwzIY
        vj/ljmRRvXz2sd4mZK3PKpb4dhCCs0grt1ugY+wQ6hxe1yU=
X-Google-Smtp-Source: ALg8bN4n18eAxFKZUngCmi6M7aI/+SvBeJ7UdnOF/NOuldpLWWdkL/phjhzdqlx9k5l3KV6bnzJR1R9xWwZUXkA6x1A=
X-Received: by 2002:a6b:c005:: with SMTP id q5mr13127059iof.225.1545843454862;
 Wed, 26 Dec 2018 08:57:34 -0800 (PST)
MIME-Version: 1.0
References: <20181201103052.6653-1-tiny.windzz@gmail.com>
In-Reply-To: <20181201103052.6653-1-tiny.windzz@gmail.com>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Thu, 27 Dec 2018 00:57:23 +0800
Message-ID: <CAEExFWseRnG8pL=o5Yc4nMrV_cmHuaOLcQq4agkJk_v0srgaWA@mail.gmail.com>
Subject: Re: [PATCH] memory: tegra: convert to DEFINE_SHOW_ATTRIBUTE
To:     Thierry Reding <thierry.reding@gmail.com>, jonathanh@nvidia.com
Cc:     linux-tegra@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping......
