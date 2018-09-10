Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C624C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 09:07:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23A0420866
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 09:07:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vsVuMAq/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23A0420866
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727875AbeIJOAR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 10:00:17 -0400
Received: from mail-ua1-f43.google.com ([209.85.222.43]:37000 "EHLO
        mail-ua1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbeIJOAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 10:00:17 -0400
Received: by mail-ua1-f43.google.com with SMTP id y10-v6so16731465uao.4
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 02:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=cU1Ska6bU7mjjEUuX+aOW7fza4X7F36h/5zKOcO6Y9U=;
        b=vsVuMAq/EK6v03J88MQA6r0vBVID1+32VDVlvYZ8Og8SUMLF3haxQtVIutnYukbnB4
         H0HRBd0RFmGCtA+wGPZMNavolBWVMaI0Ja5mp+gt8LOYOaJb+Gy2MYWXr3d616xegk6v
         8bAbw1fu0aOM11SNqWCRAIPHpHrDwLmXjPoKgKRxtqF+LFNsBbVnODAAuMNiGSvnTaH/
         5qYv2SlffQYTiwsUmsudJtopI/cSWFOtCtPSoSfjt/bcNfUBJ3w2Sm6zw+CPmGA/mrR0
         6QpmUhFJXoAt4zMDiAiINgTu8GT/eTNN3A5qNYSKdIo+WmvleoqfWORIs73xZYtlxYGK
         Sa6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=cU1Ska6bU7mjjEUuX+aOW7fza4X7F36h/5zKOcO6Y9U=;
        b=Y/sBPWKfSxQPVJK3zD+GT0MbHJKb4nZpN7u0E3NBMQjkarIQSBjhV1YWYfipPgLxgW
         a/RBeFtWOwv+hQ4MVeA6q256S10AbglfUsX8lBNpvJOnpDseZMDX7l0XLg7YpvbPvlks
         H+oWfnLqojjOz4D40EhSNo8pqJhX6XWd2/uVN3m5qR2upUEZJaSTmsrJjIMyatmHRXxE
         bFPN29+WQGjDQkW2Nvu3E8MOt9QswMcC68Njmy2jg77DWGWvhmuy8kz//+5i8HH/DAKL
         DEoBrX/8WIHfEHD5MgAFtsF3jX8iIfgeO+dYFs4n/5yOETf7fIY3CdaMN5/fmQhnGJk/
         K/ow==
X-Gm-Message-State: APzg51DHVu3uLmaoKoeTlrUrvyghwuxg32y6uIcL04f3fpPlIHjkdYYX
        frmCqvwL2YRD3Sn9a2zSK6tLomx+ymj6Mor5fKmIgCZi
X-Google-Smtp-Source: ANB0VdZdb4bSGe/w6C+uMISDJOLMlXRGLtXg4Z74H8Die4aWdmtp81xmfbzUKuahhuO4J+ozwS54oor/NdVwJdtEK6I=
X-Received: by 2002:ab0:2687:: with SMTP id t7-v6mr6758079uao.195.1536570433610;
 Mon, 10 Sep 2018 02:07:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1f:2854:0:0:0:0:0 with HTTP; Mon, 10 Sep 2018 02:07:12
 -0700 (PDT)
In-Reply-To: <20180910082715.11506-2-nautsch2@gmail.com>
References: <20180910082715.11506-1-nautsch2@gmail.com> <20180910082715.11506-2-nautsch2@gmail.com>
From:   =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
Date:   Mon, 10 Sep 2018 02:07:12 -0700
Message-ID: <CANP3RGfGkH33mYDrenwWVkQ4uG4qyrddA+yvJ+t+=y6wGd7uDA@mail.gmail.com>
Subject: Re: [PATCH 1/1] ipv6: Add sockopt IPV6_MULTICAST_ALL analogue to IP_MULTICAST_ALL
To:     Andre Naujoks <nautsch2@gmail.com>
Cc:     Linux NetDev <netdev@vger.kernel.org>,
        Kernel hackers <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>, kuznet@ms2.inr.ac.ru,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Erik Kline <ek@google.com>,
        Thomas Gleixner <tglx@linutronix.de>, Shaohua Li <shli@fb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Any reason not to use the same bit that is used by ipv4?
(as in add the setsockopt/getsockopt but just toggle the v4 bit)
