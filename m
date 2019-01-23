Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 853B0C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 15:19:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 405D82184C
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 15:19:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Drz0Dfy0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726109AbfAWPTB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 10:19:01 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40091 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbfAWPTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 10:19:01 -0500
Received: by mail-pl1-f193.google.com with SMTP id u18so1326231plq.7;
        Wed, 23 Jan 2019 07:19:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JIpB2mCVisWekV7gPUDfpECk9juHE23oSRspeDhXTrA=;
        b=Drz0Dfy0pJMwj2Ycu9BQgECe6ecHQAxShKC5kUte4JcFg9DHKCo0DgCXiACBlgAm25
         K/JACJdrM+PrQTe09dAWLiORE47W7LLjKQlKLBpS8vVxCI1IPh4PRLwycnBdINGvmdAJ
         uBAXX5rZy/EM68eZvvSIbhgdb1sFBR5q07gr4mkaTFwEFooHpE4P7rHBhq6xDEPjstT/
         SOdrH1du0wXTnIfpFgrGxjXZgy0kue7Rm9ca6/DM1zomfEoE5josQihLDYmv4veZP6N0
         B5snCxXlFmnpKyeQzuzoLKsZ17WUpP/ewxulKFodr8hbee5lSKvr/souBT9PKmyJ9Kvr
         MJXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JIpB2mCVisWekV7gPUDfpECk9juHE23oSRspeDhXTrA=;
        b=AQmwHqXbllPdkNHVF+O/UVNJclX+hSx0O3KzQKItY6/nPgs69aGZimXB3pzjzGgP+Q
         iN9qpwEVDdkQ/lkuZmzf6ZRPo3AlFi/EeVZbWHniTycxpUGwOhT7rBPkXvY9F5GEAcRj
         kRSQZBZHZ+O+NfhLSSix6VfjiWf4jYSknUjshmZ/uG7qXqq55tIWf/YykQpRfOQMhVGG
         2D7brgKTlgRYEjBL0h/EjrP/pSfFu+JsfzWkLvu7oCmWZhFMHMTs5E0r4OTGlz5NJm4I
         tH9EliuqCsGQ3BOI/uHcIhjnIQJeXZzH+9Jvb6lB274U2Ix5OhLzIxcXbwR9/mej6XkH
         FXiA==
X-Gm-Message-State: AJcUukdbFbyQ5rWyjEFZQTN97HbvJQTgItMTRdDfH77phfGpssD4rWr8
        csBAto9ZCL96MHafXCPbOEn5ckBMQPMrdiB1fzA=
X-Google-Smtp-Source: ALg8bN4dkf0RybAmoR0gqnBuzk3WsVePcU5VYVm5aWgORj10FKR46HpfCmCGWL2ua7HOQ6ZuYfvBwIx8WnLUVAMuJjo=
X-Received: by 2002:a17:902:112c:: with SMTP id d41mr2504123pla.144.1548256740394;
 Wed, 23 Jan 2019 07:19:00 -0800 (PST)
MIME-Version: 1.0
References: <1547475005-23435-1-git-send-email-guan.yung.tseng@ni.com>
In-Reply-To: <1547475005-23435-1-git-send-email-guan.yung.tseng@ni.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 23 Jan 2019 17:18:48 +0200
Message-ID: <CAHp75VcxtSi64qsK6tHx+vtEeRsX3ZVwfzRYOVuyS=qSTnK0qQ@mail.gmail.com>
Subject: Re: [PATCH] 8250_pci.c: Update NI specific devices class to multi serial
To:     Guan Yung Tseng <guan.yung.tseng@ni.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2019 at 4:13 PM Guan Yung Tseng <guan.yung.tseng@ni.com> wrote:
>
> Modified NI devices class to PCI_CLASS_COMMUNICATION_MULTISERIAL.
> The reason of doing this is because all NI multi port serial cards
> use PCI_CLASS_COMMUNICATION_OTHER class and thus fail the
> serial_pci_is_class_communication test added in the commit 7d8905d06405
> ("serial: 8250_pci: Enable device after we check black list").

Guan, can you provide an output of the

lspci -nk -xx -vv -s <BDF>

of your device, where <BDF> is a PCI address in a form of bus:device.function?

-- 
With Best Regards,
Andy Shevchenko
