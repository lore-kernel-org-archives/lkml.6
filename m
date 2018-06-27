Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43BE3C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 15:38:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBB8024169
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 15:38:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gofb7Ulf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBB8024169
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965480AbeF0Pio (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 11:38:44 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:52534 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934483AbeF0Pin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 11:38:43 -0400
Received: by mail-it0-f65.google.com with SMTP id p4-v6so777124itf.2;
        Wed, 27 Jun 2018 08:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=MA0kE+IifAd/sCheKBSMOTc4zO3MCi45ENF9v5o/VLY=;
        b=gofb7UlfZovkQyEWgvOP6Q0opA7sD0SkTlE7zs1EmhuorqyAJcpANfQYE5IwHBYZXm
         9QaPc4GD4/JS7jOWBzqwh8H2ZGu4sYO8tqcocoWJR5OPgRDBN+4g96nPaqI4QsWj4gAM
         RC4GG/adxdrXU9Vltf50k2hbBQsSK8hdbp7OfBGEAfvgJYune9gPv1j9P4oVno8eUism
         ruFDHM26xWG9WZYb0mr/4eFWIKAVUtWEnZ9NQdgIibfPYpYr02u5NfyqayGei5xlcETD
         RlKYa3MZOQG0ZWyFF5S8Ir7x4PIjG/CQsMRu8j3DWfIi2goR8ToT/D1YJhmMLk9NHddS
         caMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=MA0kE+IifAd/sCheKBSMOTc4zO3MCi45ENF9v5o/VLY=;
        b=BGglyIgcgaHMxZ5pWRVieq+5VkKSZQYrKgIlAKGlbqm6Iu1Q0wuNeESaIdO1H14FB2
         tdOe9F83jY/ohCdvXqKsflzME0fzb6U1DDgDDY0kF4LkqluHEvfm13bGNGK0wuoFVBov
         1k4xuh3vfgupzXPQjBUdgo+BhjvPKz99S8dY4HmwjxRjXMK+wAYp/fHDfA4H7kQmNMZo
         LQevwt02Apl29zkF76zDMDlOEnsZbe0aNL3S187aZ+B51m9IP3EMWGxKn2sBFiwvzBnA
         zB78r+gG5VooHA2L+2JdG/WaEEZY7BeLRJAH+8vzKc/ImKphO8xSuZXG7Knjk+Js2arG
         YbYQ==
X-Gm-Message-State: APt69E24LSYnARxNImvYrtl2ZSA2pJYundtV40Wcy6weUWMECAV7MAWU
        SsDcAh7WdWYb85uYWywLjCdCSAEKoco3XsXap/Q=
X-Google-Smtp-Source: ADUXVKLpKGjrIWNsblH9/klhF8KuVGKcyp471Za5aApunGHVgGsesJsfu6neZtYjRObzYKmWS4E+dGa50sTU5P0/4hE=
X-Received: by 2002:a24:4457:: with SMTP id o84-v6mr5356096ita.142.1530113922758;
 Wed, 27 Jun 2018 08:38:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:ef03:0:0:0:0:0 with HTTP; Wed, 27 Jun 2018 08:38:02
 -0700 (PDT)
In-Reply-To: <72f02552-9375-bf81-6a03-42656168b583@gmail.com>
References: <1530100216-13070-1-git-send-email-laoar.shao@gmail.com>
 <c89b70f9-e70d-35a5-b9a7-7e3ed7d34edf@gmail.com> <CALOAHbCdRjq2n37GpeBdorcbxXMDX2vNDLftypViJd5hRTA28A@mail.gmail.com>
 <72f02552-9375-bf81-6a03-42656168b583@gmail.com>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Wed, 27 Jun 2018 23:38:02 +0800
Message-ID: <CALOAHbCRJWThE6oLH0m9ZV8xRMMCaZFM68eSGcm8awRbCLqOsw@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: replace LINUX_MIB_TCPOFODROP with
 LINUX_MIB_TCPRMEMFULLDROP for drops due to receive buffer full
To:     Eric Dumazet <eric.dumazet@gmail.com>
Cc:     Eric Dumazet <edumazet@google.com>,
        David Miller <davem@davemloft.net>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 27, 2018 at 11:27 PM, Eric Dumazet <eric.dumazet@gmail.com> wrote:
>
>
> On 06/27/2018 08:14 AM, Yafang Shao wrote:
>
>> Got it!
>>
>> What about introduce a new counter, i.e. TCPRcvQFullDrop ?
>
> tcp_try_rmem_schedule() can fail for many different reasons,
> not related to how occupied the socket receive queue is.

Yes. So TCPRcvQDrop would be more specific ?

Thanks
Yafang
