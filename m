Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751831AbeBZXFO (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 18:05:14 -0500
Received: from mxf98a.netcup.net ([46.38.249.138]:41071 "EHLO
        mxf98a.netcup.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751518AbeBZXFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 18:05:13 -0500
Authentication-Results: mxf98a;
        spf=pass (sender IP is 77.7.26.24) smtp.mailfrom=rabel@robertabel.eu smtp.helo=[192.168.178.21]
Subject: Re: [PATCH 3/4] auxdisplay: charlcd: fix x/y address commands
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Willy Tarreau <w@1wt.eu>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
References: <9ec3c54c-f8fe-22d7-783e-8cf9862405bb@robertabel.eu>
 <20180225235432.31209-1-rabel@robertabel.eu>
 <20180225235432.31209-2-rabel@robertabel.eu>
 <20180225235432.31209-3-rabel@robertabel.eu>
 <20180225235432.31209-4-rabel@robertabel.eu>
 <CANiq72mu2NkDx4XqXzcO39N8AZg50h+BxrONJ3eCc7LjJ0rJKg@mail.gmail.com>
From: Robert Abel <rabel@robertabel.eu>
Message-ID: <1a02d35e-b87c-3751-eb1a-f3becee4aa6b@robertabel.eu>
Date: Tue, 27 Feb 2018 00:05:10 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CANiq72mu2NkDx4XqXzcO39N8AZg50h+BxrONJ3eCc7LjJ0rJKg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: <20180226230512.12154.97579@mxf98a.netcup.net>
X-PPP-Vhost: robertabel.eu
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miguel,

On 26 Feb 2018 17:49, Miguel Ojeda wrote:
> On Mon, Feb 26, 2018 at 12:54 AM, Robert Abel <rabel@robertabel.eu> wrote:
>> +               /* clamp new x/y coordinates */
>> +               if (tmp_addr.x >= lcd->width)
>> +                       tmp_addr.x = lcd->width - 1;
> 
> tmp_addr.x = min(tmp_addr.x, lcd->width - 1);

Had throught of that, too. However, it introduces a warning about type
mismatch, because lcd->width is int while tmp_addr.x is unsigned long
int. I didn't fell like saving a line warranted much bigger changes to
the lcd struct.

Regards,

Robert
