Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4118280-1518780077-2-6355572462232355150
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='windows-1252'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518780077; b=JD6zprreXCgaLtLCJAY+ZdOAZnWkSK1ZIHv+QS85MYKYdnC
    IXkzjAYrqx/OWFwMGerHpTHX3iCaGIRDgE9OlaY7vpu6275ZZ3xfRzkMuGcIy8O5
    sTcndqxhrb2PhU7EEwtFnmp41Dqdru9K6r0tVm32UPdiWS0uFAvUIPIFbGvXUD3L
    v6N4r0QccKoPKe//CMNkJtIvQU4DsU2t9wmj39c813YEwtOoRrrZTdBcDcO8m2Xb
    qhUrG/sHec/G0Haah6I9T2waYkMTcZW71VrcMNqQ/G9vk04/wgGJLFCZMg1VT5Kh
    nF13T4/MKkC8r9uX1JgUtXcmwS7TgY4/G97gceA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:cc:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1518780077; bh=D1xY+I0FAhTb70Ew2sWjcJRs+Ezu/D2L166WW8Ee2dI=; b=m
    MPks+Ez9p9BvNreXsy88KUDwv9Bcw8W2fsA85BPfkXzL8sxxwNTr4D73bmqc+B2N
    6wtn1PDmvLp4YZl5WL+/zBcgQkQolILNW1cqrzT4V5kt+DTF1QeSPPJS6nu+UggR
    +2UBJC1ZIAyGdRmdY1B8NAW0hKKzEE5XbjsX5mWTUi6sLAjdw6AICa4f+7Xvlugu
    /QWFNsOLmNuBtMpCwLSzSHHlDYLe99CSWQP/FQJkHlOH+KuBcZ9Ne7nt+0ruMVTM
    trqRkXz8klSeZ+EE+YwO5UlgF27z9Gl1f9nzIBXcD9OSMAh9zuv306eLwv5toLq4
    pEhJM/AaXkRbCweiQgoHg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=ti.com header.i=@ti.com header.b=NzuaqAqm x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=ti-com-17Q1;
    dmarc=pass (p=quarantine,has-list-id=yes,d=none) header.from=ti.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ti.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=ti.com header.i=@ti.com header.b=NzuaqAqm x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=ti-com-17Q1;
    dmarc=pass (p=quarantine,has-list-id=yes,d=none) header.from=ti.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ti.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935438AbeBPLVN (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Feb 2018 06:21:13 -0500
Received: from lelnx193.ext.ti.com ([198.47.27.77]:33092 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935394AbeBPLVN (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 16 Feb 2018 06:21:13 -0500
Subject: Re: [PATCH] phy: allwinner: sun4i-usb: poll vbus changes on A23/A33
 when driving VBUS
To: Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>
References: <20180119092541.7508-1-wens@csie.org>
 <20180119144512.dqqbywavhwsyma2f@flea.lan>
CC: Hans de Goede <hdegoede@redhat.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-sunxi@googlegroups.com>,
        <stable@vger.kernel.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <a38e269f-abe9-0560-1542-c115c5a64605@ti.com>
Date: Fri, 16 Feb 2018 16:50:42 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <20180119144512.dqqbywavhwsyma2f@flea.lan>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On Friday 19 January 2018 08:15 PM, Maxime Ripard wrote:
> On Fri, Jan 19, 2018 at 05:25:41PM +0800, Chen-Yu Tsai wrote:
>> The AXP223 PMIC, like the AXP221, does not generate VBUS change
>> interrupts when N_VBUSEN is used to drive VBUS for the OTG port
>> on the board.
>>
>> This was not noticed until recently, as most A23/A33 boards use
>> a GPIO pin that does not support interrupts for OTG ID detection.
>> This forces the driver to use polling. However the A33-OlinuXino
>> uses a pin that does support interrupts, so the driver uses them.
>> However the VBUS interrupt never fires, and the driver never gets
>> to update the VBUS status. This results in musb timing out waiting
>> for VBUS to rise.
>>
>> This was worked around for the AXP221 by resorting to polling
>> changes in commit 91d96f06a760 ("phy-sun4i-usb: Add workaround for
>> missing Vbus det interrupts on A31"). This patch adds the A23 and
>> A33 to the list of SoCs that need the workaround.
>>
>> Fixes: fc1f45ed3043 ("phy-sun4i-usb: Add support for the usb-phys on the
>> 		      sun8i-a33 SoC")
>> Fixes: 123dfdbcfaf5 ("phy-sun4i-usb: Add support for the usb-phys on the
>> 		      sun8i-a23 SoC")
>> Cc: <stable@vger.kernel.org> # 4.3.x: 68dbc2ce77bb phy-sun4i-usb:
>> 		Use of_match_node to get model specific config data
>> Cc: <stable@vger.kernel.org> # 4.3.x: 5cf700ac9d50 phy: phy-sun4i-usb:
>> 		Fix optional gpios failing probe
>> Cc: <stable@vger.kernel.org> # 4.3.x: 04e59a0211ff phy-sun4i-usb:
>> 		Fix irq free conditions to match request conditions
>> Cc: <stable@vger.kernel.org> # 4.3.x: 91d96f06a760 phy-sun4i-usb:
>> 		Add workaround for missing Vbus det interrupts on A31
>> Cc: <stable@vger.kernel.org> # 4.3.x
>> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>> ---
>>
>> This list might get longer if the newer AXP8xx PMICs also have this
>> behavior. We could switch to a boolean in the per-compatible data,
>> or just always use polling. The yet-merged R40 support will have this
>> issue as well, as the R40 is paired with the AXP221. But for now,
>> I'd like to have something that is easier to backport to stable, so
>> we can at least fix this for the A23 and A33.
>>
>> Also, checkpatch.pl doesn't like the stable kernel prerequisite lines.
> 
> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

merged, thanks!

-Kishon
