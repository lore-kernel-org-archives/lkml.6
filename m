Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1423100AbeCBIqy convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 03:46:54 -0500
Received: from mail1.bemta26.messagelabs.com ([85.158.142.4]:25366 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1423071AbeCBIqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 03:46:52 -0500
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMKsWRWlGSWpSXmKPExsUSt3OpsW4V/8w
  og1MT+C3a3y1jt7i8aw6bxbHVV9gcmD3mran2+LxJLoApijUzLym/IoE1o/31duaCn1wVP5uD
  Gxg7ObsYuTiEBJYwSlxYPJWti5GTg03AUGLem/eMILaIgKlEa+MuoDgHB7NAtcTWU+kgYWEBK
  4mZ706yQZTYS2x9cI0JwtaTOPD5Klgri4CKxOZp+8FsXoEAifsbn4HVMArISnxpXM0MYjMLiE
  vcejIfLC4hICCxZM95ZghbVOLl43+sELa8xM1Xx1ggbHuJ1/fesYCcIyGgL9HXWAwRNpRYNe0
  AVIm5xIZ1f9khxutILNj9iQ3C1pZYtvA1M8Q5ghInZz5hmcAoOgvJFbOQtMxC0jILScsCRpZV
  jOZJRZnpGSW5iZk5uoYGBrqGhsa6xroWeolVuol6qaW6yal5JUWJQDm9xPJiveLK3OScFL281
  JJNjMAIYwCCHYzrviQeYpTkYFIS5fV7MSNKiC8pP6UyI7E4I76oNCe1+BCjDAeHkgRvJt/MKC
  HBotT01Iq0zBxgrMOkJTh4lER4z/ECpXmLCxJzizPTIVKnGHU5brx43cYsxJKXn5cqJc6rDjJ
  DAKQoozQPbgQs7VxilJUS5mUEOkqIpyC1KDezBFX+FaM4B6OSMK84yBSezLwSuE2vgI5gAjqC
  /e0MkCNKEhFSUg2MNa92aOXf4rmVlP5hpZ7K7MNz8hVaj8+o89iZXsxcdGXFV0+dFz3TF4SfE
  rhgY2MX0b4nXrFDUtAjp2x77lHXl2nvleKTuarkHSrz4/4a+oh822K/+O/qHfynXFiFb+cLft
  l1a23Ovik/dq3Uef2ObV3vqW8HOK7/LPt2+t/nlx2PH/l3beUyVWIpzkg01GIuKk4EAD6LhOs
  2AwAA
X-Env-Sender: stwiss.opensource@diasemi.com
X-Msg-Ref: server-45.tower-223.messagelabs.com!1519980409!127839!1
X-Originating-IP: [94.185.165.51]
X-StarScan-Received: 
X-StarScan-Version: 9.4.45; banners=-,-,-
X-VirusChecked: Checked
From: Steve Twiss <stwiss.opensource@diasemi.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>
Subject: RE: [PATCH 000/100] rtc: remove cargo culted code
Thread-Topic: RE: [PATCH 000/100] rtc: remove cargo culted code
Thread-Index: AdOyAArsyG19aOFaT3ybTGNGmH1biA==
Date: Fri, 2 Mar 2018 08:46:48 +0000
Message-ID: <6ED8E3B22081A4459DAC7699F3695FB701941570C7@SW-EX-MBX01.diasemi.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.20.26.49]
x-kse-attachmentfiltering-interceptor-info: protection disabled
x-kse-serverinfo: sw-ex-cashub01.diasemi.com, 9
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: Clean, bases: 02/03/2018 05:18:00
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 21, 2018 at 8:54 PM, Alexandre Belloni wrote:
 
> subject:	[PATCH 000/100] rtc: remove cargo culted code
> mailing list:	linux-kernel@vger.kernel.org Filter messages from this mailing list
>
> Hello,
>
> This series:
>  - removes useless calls to rtc_valid_tm in .read_time, .set_time and
>    .set_alarm
>  - removes code setting default values for RTCs (and lets the core
>    handle it)
>  - removes useless "time is invalid" messages at probe time
>  - removes useless indirect calls
>
> Those were mostly copy pasted from other drivers

Hi Alexandre,

Acked for:
  rtc: da9063: stop validating rtc_time in .read_time
  rtc: da9052: stop validating rtc_time in .read_time
  rtc: da9055: stop validating rtc_time in .read_time

Acked-by: Steve Twiss <stwiss.opensource@diasemi.com>

Agreed -- rtc_valid_tm() call is cargo cult for the above.

(By definition) for DA9063 I was trying to be rigorous.
The .read_time function is slightly different here because I can make a copy the alarm time into the RTC time
structure to solve an RTC synchronisation problem internally to the DA9063.
https://elixir.bootlin.com/linux/v4.5.6/source/drivers/rtc/rtc-da9063.c#L253

But after some further looking, I have not got any explicit case of how the time read directly from the DA9063
registers can be incorrectly represented. So there should be no need to check this.

Regards,
Steve
