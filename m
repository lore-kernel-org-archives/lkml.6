Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18581C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 21:12:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0935208A1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 21:12:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WHXL0koV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0935208A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754482AbeGEVMT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 17:12:19 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:33831 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754424AbeGEVMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 17:12:17 -0400
Received: by mail-qt0-f196.google.com with SMTP id m13-v6so8351936qth.1;
        Thu, 05 Jul 2018 14:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IU4R1F9SKGzCY9r0fyUHrtReWS/2tc6fO9eYQn8YtRU=;
        b=WHXL0koVrxxfspe78HqOGIM4qETVXcu3hPifJTDGvQ4Oy4ZRtVmc1gvdpDLhRy0/7z
         hZE6VGLqu7X0AgVHsSe7WsHjCyeGWY4bkVMzZjEoLrRHlW58eTsBkzGc9OkIBIV1Ij/g
         0FX5PuM9u/peb2Hd7VUq1H6ei3pf5J6DewcBz1o2YdYemCsi9ic+CTciYv6DcZcTYYg+
         8B2YVXOV+A+Ib9fgPTlucRuLIqOdYhnQjVocrs+EWtNO1bXNEQ4P00+VSyWhxOUfyKyo
         Qbs6oyYWmZePa6/VylVOvBrrw8vrXzQbQTclMxCo3e4Nws0cXPvHq7MSaQMEQsKNnSqV
         3F9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IU4R1F9SKGzCY9r0fyUHrtReWS/2tc6fO9eYQn8YtRU=;
        b=Ng1Kvc/riQMkiR2KRxILfZHvyG8yyWPE55BJRfOC32YM21u2v6d+KXj7Yl5hm9bZr2
         NcHOWuqUVWmiGpzHXB6WKqrms/0K3xWqkeRrqWTDVMcHToScm81NwSQD+84uLk+afUNo
         UaOlYxBKjOLhEg/rGeI+MWqNSv183WlmssAwvPrYlvpTgZGCjeNzHWeo4gngN3h7pIru
         zJSarp8fznLghEby8VTeebAilOUPLCq3vexpagtT49bVV5dZHn81lzZnLThrXpf9WYxL
         BF8kUP9JfgCdr+tLG2/0Z5GdHnyqzzqYbCGeA+YiOTIDYt5bqGSZYyBgPOGO3cSR+kON
         Azpg==
X-Gm-Message-State: APt69E1Uzqon7D8+xecDzWJ0df6mxkqmRRbCYfzSDBYbAJ4OD12DXMiK
        dcekCVaFgVx6vhLf2GV30CFV4r+NN63UuQmcVq8=
X-Google-Smtp-Source: AAOMgpcCQxm8ZKnYipy1FrQkNz5k1ihPQV321UwtFHF+HVvIO0Pz3eet8iXnXtsR4ovvAcDamczT5F/vklw9/WEh5no=
X-Received: by 2002:aed:3de2:: with SMTP id j31-v6mr6611461qtf.3.1530825136880;
 Thu, 05 Jul 2018 14:12:16 -0700 (PDT)
MIME-Version: 1.0
References: <20180628054205.17737-1-luaraneda@gmail.com> <20180628054205.17737-6-luaraneda@gmail.com>
 <042f6632-f4f6-d278-9859-b8998468c3bf@xilinx.com> <CAHbBuxpuAC0PDfFBQ+D_zJu-AmWFNhEWCojr8LAWfO-ootLqEg@mail.gmail.com>
 <20180703230745.GA2129@rob-hp-laptop>
In-Reply-To: <20180703230745.GA2129@rob-hp-laptop>
From:   Luis Araneda <luaraneda@gmail.com>
Date:   Thu, 5 Jul 2018 17:12:00 -0400
Message-ID: <CAHbBuxpO6egKoHQizuuWM3LrK-m+-GpTjrcPey55UBMP02zozQ@mail.gmail.com>
Subject: Re: [RFC PATCH 5/5] arm: dts: zynq: remove "zynq" prefix from
 compatible property
To:     robh@kernel.org
Cc:     Michal Simek <michal.simek@xilinx.com>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Tue, Jul 3, 2018 at 7:07 PM Rob Herring <robh@kernel.org> wrote:
> Maybe so, but you can't just go around changing compatible strings. Once
> set, it's an ABI.

Ok, I'll drop the patch from v2.

Thanks,

Luis Araneda.
