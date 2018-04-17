Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752199AbeDQIUj convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 04:20:39 -0400
Received: from smtpgwcipde.automotive.elektrobit.com ([213.95.163.141]:57437
        "EHLO smtpgwcipde.elektrobit.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752135AbeDQISY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 04:18:24 -0400
From: <Tobias.Jordan@elektrobit.com>
To: <wsa@the-dreams.de>
CC: <der.herr@hofr.at>, <linux-i2c@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: RE: [SIL2review] [PATCH] i2c: img-scb: fix PM device usage count
Thread-Topic: [SIL2review] [PATCH] i2c: img-scb: fix PM device usage count
Thread-Index: AQHTrjt0dQSN4VmZz0CI1P0T6XZe26O1PdUAgE6BXICAASWIwA==
Date: Tue, 17 Apr 2018 08:03:07 +0000
Message-ID: <84353cd0444f41c4aebbc1b6eb2eeae3@denue6es008.ebgroup.elektrobit.com>
References: <20180224224303.3mpwhal2axcr6aos@agrajag.zerfleddert.de>
 <20180225132014.GA8844@osadl.at> <20180225172730.2b443978@denkmatte>
 <20180416161845.hxizpjituo6mpvbm@ninjato>
In-Reply-To: <20180416161845.hxizpjituo6mpvbm@ninjato>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.5.137.27]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> Is it easily recognizable if the drivers check the error code because
> there is a reason or if they do it "out of habit"?

Probably by looking closely at the implementation of the PM callouts
for the driver, but I couldn't find a pattern that would be easy to
recognize. Maybe I didn't look close enough ;-)

I concur that removing the check would be a better approach if it's
clear that it's just done "out of habit".

Actually, the real problem is to find the drivers that need to have
the check in, add/fix it for them, and remove it for all others.

Unfortunately, all I'm currently able to do is finding the parts that
are inconsistent.

Tobias
