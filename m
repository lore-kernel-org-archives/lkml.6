Return-Path: <chunfeng.yun@mediatek.com>
X-Google-Smtp-Source: AG47ELu018TNDWZ6Qsu5uNEOfYbRgqsTIi5/n2FoXJKJHvBmv+INzpQHvtS3cOwDyjxZcHVrKFWD
ARC-Seal: i=1; a=rsa-sha256; t=1521710490; cv=none;
        d=google.com; s=arc-20160816;
        b=jcKtQUMLuL0QH/02hEbskv5Am6Fd/mUucmBSvwA2c8VQcHYZ5R4CeUIGvD5egL3MMy
         MLjuz9NwhMM/1gu1+H46PGgMgEYhxY0cFCiX7W1YJSy6xtK11u/LGUMob8EsyNL8nJiD
         shvSDzTCAVQtWUj4SX4Mrsla+m0mgbpcqaitrwhKvIpbkzmP/qaw27IR2qb5lDQuLmj8
         slBhtqYA9qD9S+JOjKl07VHBqNb3uNl4fnYCoWkX+uTP96LV+Q5eFEAyTAVav8nNXnz4
         oXd08vI9KvIZOvELpT+C4F+auIikIk9tc6pWF4iwTzQaW2o3GHO3MV8txVfNVU9MtD5/
         hpCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:references:in-reply-to:date
         :cc:to:from:subject:message-id:arc-authentication-results;
        bh=NtYX0xGXuRFRt8Xf1HtLYDYWTTwmr4nK6Giltohj3zE=;
        b=u69WrivZp2MiMU+ax2GKojghryhQjwy7oGq8t58zF150phpDXAvFVeKc9ellrxTGvt
         YuYylGTPswao/xYhItCXxvjIzo7vIWJF//6DxGp9ScbvA9KhaMxKzAtPNA2xmOYvmIv0
         tu3xXebIwaL//pRaK81YoFtChtaNmhpwEZU1201La8IbSqDINQlPl75pGTMDCfySHCRt
         qYkv7lrfCC0FRtI1ZNPOgP/uR+L+wW3R5w0aJAiGSgned0u8knMtD8KiPY74jUzoiqKO
         Eu85UabBB6ljA4pZklGbHiJnIxEw6s7tk/IxBpZN7v/fjeIsd2KVbizZzUOkyyxL3vUT
         h7JA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of chunfeng.yun@mediatek.com designates 1.203.163.78 as permitted sender) smtp.mailfrom=chunfeng.yun@mediatek.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of chunfeng.yun@mediatek.com designates 1.203.163.78 as permitted sender) smtp.mailfrom=chunfeng.yun@mediatek.com
X-UUID: 05dbc7465ed14ad9a376310152af320a-20180322
Message-ID: <1521710486.3717.146.camel@mhfsdcap03>
Subject: Re: [usb-next, v2 PATCH] usb: xhci: skip phys initialization of
 shared hcd
From: Chunfeng Yun <chunfeng.yun@mediatek.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Mathias Nyman
	<mathias.nyman@intel.com>, Matthias Brugger <matthias.bgg@gmail.com>, "Roger
 Quadros" <rogerq@ti.com>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-usb@vger.kernel.org>,
	<linux-mediatek@lists.infradead.org>
Date: Thu, 22 Mar 2018 17:21:26 +0800
In-Reply-To: <20180322090127.GA12048@kroah.com>
References: <643701fef843f91931e3a68779afe053c63c96f6.1521707846.git.chunfeng.yun@mediatek.com>
	 <20180322090127.GA12048@kroah.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK: N
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595526733993033305?=
X-GMAIL-MSGID: =?utf-8?q?1595629099910345438?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

hi, 
On Thu, 2018-03-22 at 10:01 +0100, Greg Kroah-Hartman wrote:
> On Thu, Mar 22, 2018 at 04:39:20PM +0800, Chunfeng Yun wrote:
> > The phys has already been initialized when add primary hcd,
> > including usb2 phys and usb3 phys also if exist, so needn't
> > re-parse "phys" property again.
> > 
> > Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> > ---
> >  drivers/usb/core/hcd.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> What changed from version 1?
V1: skip phys initialization when add shared HCD by setting
xhci->shared_hcd->skip_phy_initialization=1;
for both xhci-plat.c & xhci-mtk.c files.

V2: fix it in hcd.c suggested by Roger
> 
> Always put that below the --- line like the kernel documentation asks
> you to do.
> 
> v3?
> 
> thanks,
> 
> greg k-h
