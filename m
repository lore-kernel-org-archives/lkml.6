Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-119380-1521775267-2-1432573218840583143
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, UNPARSEABLE_RELAY 0.001,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521775267; b=pqZiD0mkFvKXraeAQ4FsgUa8JcZ7JZXB4gZDrMYiBs3OGGr
    FHdyxlxqiNMK3VmnO9ypvMqW+JpE+HRJbiMfvRWtIAuRr1RlMQvvgz1HfREPPiEo
    ZPCxhFz2N6B2dU79AgPZNkKh5yl91gnSMaohityLUAu/2TQ1So3keEx367yL+jzl
    S3SJU/bpYEFZo8GsJM/OfQ1gwQbRbBY/HQdo6oZ8p0+ULi6YKXUykrpxd0XWHUe1
    /IyFjVFrjOJviH3DGW55KqPyNVGCpar1iwi9oX7D1jBzkZFKqCvBq0EfxKGCTAW+
    fH/JS+hCcjrUZhvQ6wiA/aCpBU55xr8arMwE+OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:cc:date
    :in-reply-to:references:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521775267; bh=5pada3
    3iizj0StORubZmZK+dLbiVKf4IzXLoo67agx0=; b=IJn5widRaThGoNfHDNoaiD
    bW4nrsxN67FsujmqldI7Jk11bqCJl9C0efmjuEjeV1hLgI6w9zcQI/BngcQBurg3
    3TKXLDmc8HQGoKJpAz9R2RDxXmFNBIQY50MHLu+WqivXxXHgs3IWqDQWg+d30eZh
    2hG/okIf8o7pmhNqQ3PJXqb3YhkwmF59V+fK5NVmJa/ecR5Vra+lbvSN/mmV4hmB
    IUMKb1Fjm099tZDl/SZuJE61Q5P6L8uiqvv4tgvCG4q7CWZh5jfKXTG5ozvLyEO3
    C27aUiL5/rI2A8vsxsD3DC3zRhHnLShi1kk+tZcqMbBJEHa5RqXG4KzzmTSqC+hA
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mediatek.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=mediatek.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mediatek.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=mediatek.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752060AbeCWDUz (ORCPT <rfc822;greg@kroah.com>);
        Thu, 22 Mar 2018 23:20:55 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:5637 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751902AbeCWDUy (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Thu, 22 Mar 2018 23:20:54 -0400
X-UUID: 84164a624df249cea2f351405a18768b-20180323
Message-ID: <1521775248.3717.159.camel@mhfsdcap03>
Subject: Re: [usb-next, v3 PATCH] usb: xhci: skip phys initialization of
 shared hcd
From: Chunfeng Yun <chunfeng.yun@mediatek.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Roger Quadros" <rogerq@ti.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-usb@vger.kernel.org>, <linux-mediatek@lists.infradead.org>
Date: Fri, 23 Mar 2018 11:20:48 +0800
In-Reply-To: <20180322125300.GA22130@kroah.com>
References: <643701fef843f91931e3a68779afe053c63c96f6.1521707846.git.chunfeng.yun@mediatek.com>
         <20180322125300.GA22130@kroah.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK: N
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, 2018-03-22 at 13:53 +0100, Greg Kroah-Hartman wrote:
> On Thu, Mar 22, 2018 at 08:12:50PM +0800, Chunfeng Yun wrote:
> > The phys has already been initialized when add primary hcd,
> > including usb2 phys and usb3 phys also if exist, so needn't
> > re-parse "phys" property again.
> 
> Wait, why does the subject say "xhci", when this is in USB core code?
> 
> I'll go edit that by hand...
Thanks


