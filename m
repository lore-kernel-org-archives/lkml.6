Return-Path: <linus.walleij@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1526248892; cv=none;
        d=google.com; s=arc-20160816;
        b=ni8PgXfymccrH8c4wj/fhzeJGD4KrytpF7+UyL4XtiHBcM8kmoRlzmfkOSuRdvwLXD
         hiEYe548cOLZw2VDhRRgYio0jUXjN6wtws8Mk69657dHfFvpiiEBaqNW3V/0zlaUMVRM
         xdXqLAgFFVzJ7RcvIlKBTgnE56ZrcOCRsMNjMsRtN98tycwvrq/04mg6aw3HYJBzCbaT
         COPlEvdNeVZFHTp/P3vS3D0+h11IA810L88swDpcx8vYBZMuYETZ2XGyKWTZlaKzzsD5
         ahSwvPqqObT+8S3ycVOT+nEmp+Mtgh1OJg3BbrXN9gO7yU8AXpock8pUXSnC/ySlVhK7
         F6Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=UiXYJxRJDtcypnUZ7PpdGyLYguLP8qV+bta3fQNbD/4=;
        b=R3AgfE8D+fNzpy4f2GrpdIHOj3bI2guZ9Fhtt302QtQCleUHjpSE3NSSgKBsrOFSOu
         9zcvcW3qSBZBHPgJN2/74lZIITkhz7Zm9aYxxiy8IvQqbdz1Jz4U10kBlEV4QDXTm4Oh
         HPfxWtlk8HqVKxjqMpRV8vz+GKmv+0Z+Ga7REljV1I7xSj1PYg+3VbJVgkGUZPkRuPmQ
         cl1J+r3A0LgL8IDV4JT1eBQlYc2WZxdc392ZSg/+dNsTCKGfhLkAV/IzNUGeRVDCeJ50
         nCBgS/fxeMJJxfNMQ7metx0GS5C0bZT+7Em6O3uP6zwWeV9WAUDEHNU54BTiJykZLhAw
         U4gQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=bdZPnlCJ;
       spf=pass (google.com: domain of linus.walleij@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=linus.walleij@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=bdZPnlCJ;
       spf=pass (google.com: domain of linus.walleij@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=linus.walleij@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AB8JxZqV/iEsXwtiUaNTUDMgNVRGHM5zQ1d5C0vaiOnyInzhjuYBxC9jAQTY32+eOabW3uD9pRpi2B+MFjeZwrQ6Tnw=
MIME-Version: 1.0
In-Reply-To: <91dad272-e07d-2ab6-2afa-538294e9cefa@suse.de>
References: <20180501213114.20183-1-robh@kernel.org> <20180507183106.GF2259@tuxbook-pro>
 <91dad272-e07d-2ab6-2afa-538294e9cefa@suse.de>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 14 May 2018 00:01:31 +0200
Message-ID: <CACRpkdaYN-wKErERP_65T2NH6L-+8O_ugSgg7pXfkaLkn1A2KQ@mail.gmail.com>
Subject: Re: [RFC PATCH] driver core: make deferring probe forever optional
To: Alexander Graf <agraf@suse.de>, =?UTF-8?Q?S=C3=B6ren_Brinkmann?= <soren.brinkmann@xilinx.com>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>, Rob Herring <robh@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Grant Likely <grant.likely@arm.com>,
	Mark Brown <broonie@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	boot-architecture@lists.linaro.org,
	Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599298891509345819?=
X-GMAIL-MSGID: =?utf-8?q?1600387959078095058?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 9, 2018 at 11:44 AM, Alexander Graf <agraf@suse.de> wrote:
> On 05/07/2018 08:31 PM, Bjorn Andersson wrote:

>> Can you please name platform that has enough support for Alexander to
>> care about backwards and forwards compatibility but lacks a pinctrl
>> driver.
>
> ZynqMP is one example that immediately comes to my mind. I'm sure there are
> others too.

Why isn't that using drivers/pinctrl/pinctrl-zynq.c?

How is it so very different from (old) Zynq as it is already using
the same GPIO driver?

Yours,
Linus Walleij
