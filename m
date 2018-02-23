Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751339AbeBWBOo (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 20:14:44 -0500
Received: from elektron.elka.pw.edu.pl ([194.29.160.103]:60257 "EHLO
        elektron.elka.pw.edu.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750776AbeBWBOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 20:14:43 -0500
Subject: Proposal - how to make usbip more resistant to misconfiguration
From: "wzabolot@elektron.elka.pw.edu.pl" <wzabolot@elektron.elka.pw.edu.pl>
To: 891036@bugs.debian.org
References: <da4d5257-9bbd-7abb-2022-ba474aea4720@elka.pw.edu.pl>
 <6d54befc-2fbb-b1ca-cc93-00eefb5c867f@elektron.elka.pw.edu.pl>
 <7c22ea61-a9da-caa6-5b69-06e3dfefdb44@elektron.elka.pw.edu.pl>
Cc: LKML <linux-kernel@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
        "linux-usb@vger.kernel.org >> linux-usb"@vger.kernel.org
Message-ID: <19aaf781-851b-fc26-239a-a6fc8494fd5c@elektron.elka.pw.edu.pl>
Date: Fri, 23 Feb 2018 01:56:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <7c22ea61-a9da-caa6-5b69-06e3dfefdb44@elektron.elka.pw.edu.pl>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: pl-PL
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have found that the
https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=891036 is not the only
one related to misconfiguration of the usbip driver and tools.
A few weeks ago the similar bug
https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=878866 was discovered.
It seems that the configuration of usbip is fragile, and it is easy to
make a mistake leading to the setup that doesn't work correctly.
I suppose, that additional mechanisms should be added to prevent such
problems:

 1. It should be checked DURING THE COMPILATION, that the number of
    ports in a single virtual hub does not exceed 128.
 2. The MAXNPORT constant in tools/usb/usbip/libsrc/vhci_driver.h should
    be defined as:
    #define MAXNPORT ( VHCI_PORTS * VHCI_NR_HCS )

I have not tested the above modifications. If I find some time to verify
them, and if they are correct, I'll submit the official patches.

With best regards,
Wojtek

-- 
Wojciech M Zabolotny, PhD
Institute of Electronic Systems
Faculty of Electronics and Information Technology
Warsaw University of Technology
