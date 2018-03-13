Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751648AbeCMPH3 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 11:07:29 -0400
Received: from mail-io0-f181.google.com ([209.85.223.181]:37484 "EHLO
        mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751276AbeCMPH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 11:07:28 -0400
X-Google-Smtp-Source: AG47ELsuPq3spbNl2UV8jxsZ/CXl9032zt1YSf6O2ySSUFmVsU0IuO/oM9PYdCmgdVk7xhWDazscSciAU5I4LkKPR9k=
MIME-Version: 1.0
From: =?UTF-8?Q?Oskar_Jagodzi=C5=84ski?= <oskar.jagodzinski@allegro.pl>
Date: Tue, 13 Mar 2018 16:07:26 +0100
Message-ID: <CAEVoMY0_sjOuC9Pa1L=_ShsH2iywksnOzSsOrcY7GajZHOVGrw@mail.gmail.com>
Subject: PMTU discovery mechanism on closed UDP socket, no entry added
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

When I send UDP packet (too big for whole path) and close socket right
after, ICMP Fragmentation Needed packet is ignored (?) and no entry
regarding path MTU is created. When process waits before closing
socket (about 1s in my case) entry about path MTU is added to routing
table.
The result is that when I send single big (bigger than minimal MTU in
path) UDP packet very rarely none of them reaches destination. When
there is continuous stream of packets and there is always open socket
for this destination IP everything (regarding path MTU discovery
mechanism) works as expected.

Is there any way to change this behaviour? Or is this some kind of
DDoS protection mechanism? I am aware of timeout of table MTU entries
but "very rarely" in my case means more often than timeout value.

Environment:
- Ubuntu 14.04.5 LTS, kernel 4.4.0-104-generic #127~14.04.1-Ubuntu
- Intel(R) 2P X520/2P I350 rNDC | Intel Corporation 82599ES
10-Gigabit, driver=ixgbe driverversion=4.2.1-k, 18.3.6 (firmware
driver from Dell)

Code used for testing and my network architecture:
- https://pastebin.com/raw/ECY3Xxtg
- https://i.imgur.com/T7SpDyP.png

-- 
Oskar Jagodzinski
