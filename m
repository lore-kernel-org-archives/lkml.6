Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752604AbeCMIwT convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 04:52:19 -0400
Received: from mail1.bemta5.messagelabs.com ([195.245.231.152]:10399 "EHLO
        mail1.bemta5.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752509AbeCMIwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 04:52:17 -0400
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFKsWRWlGSWpSXmKPExsUSt3Opsa7dxOV
  RBq8uGFhMffiEzeLblQ4mi8u75rBZHFzYxmixde9VdgdWj8YbN9g8ds66y+6xaVUnm8fnTXIB
  LFGsmXlJ+RUJrBmbVq1kLLjMUrH1/jzmBsaPzF2MXBxCAksZJeZdWwHkcHKwCVhITD7xgA3EF
  hEokvj8fwcrSBGzwCpGie1TljOCJIQFPCVONe1hgSjykliw+wIzhG0k0XNsAzuIzSKgKrFn3z
  GwGl6BAIlfq9eB1QgJmEkseX0WbAGngLnEvsa7rCA2o4CsxJfG1WA1zALiEreezGcCsSUEBCS
  W7DnPDGGLSrx8/I8VwpaX2P7tNzuEbS/x+t47oF0cQLa+RF9jMUTYUGLVtAMsELa5xKuvE9gh
  xusAnfyJDcLWlli28DUzxJmCEidnPmGZwCg+C8kVs5C0zELSMgtJywJGllWMGsWpRWWpRbqGx
  npJRZnpGSW5iZk5uoYGpnq5qcXFiempOYlJxXrJ+bmbGIExygAEOxj/bfM8xCjJwaQkymsYuj
  xKiC8pP6UyI7E4I76oNCe1+BCjDAeHkgRv0gSgnGBRanpqRVpmDjBZwKQlOHiURHgVQNK8xQW
  JucWZ6RCpU4zGHG0rn7Qxc9x48bqNWYglLz8vVUqc1xmkVACkNKM0D24QLIldYpSVEuZlBDpN
  iKcgtSg3swRV/hWjOAejElAFyBSezLwSuH2vgE5hAjrlyoklIKeUJCKkpBoYlz51vb/2xgvP6
  U/Cy54pP5Taxl5d0StTsdbtQF/oRt+fx34o+9++NltS6oTXm+yvE1ZNaQzZye75IkO6drvXir
  mXvuUpxF6YeiWa0X3R5/VRT84KX1zx44585qVZN9IW/L+v+KTR+d7BpjnRF5JDOwJSGlXS7n6
  3ES2YZ/Y+ll/22+lVtnuF25VYijMSDbWYi4oTAW91ln5dAwAA
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-6.tower-180.messagelabs.com!1520931134!100180447!1
X-Originating-IP: [94.185.165.51]
X-StarScan-Received: 
X-StarScan-Version: 9.4.45; banners=-,-,-
X-VirusChecked: Checked
From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>,
        Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
CC: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: RE: linux-next: build failure after merge of the sound-asoc tree
Thread-Topic: linux-next: build failure after merge of the sound-asoc tree
Thread-Index: AQHTupHoyxpYAIsdxU2zyWH6EWEY7aPN2xXg
Date: Tue, 13 Mar 2018 08:52:12 +0000
Message-ID: <2E89032DDAA8B9408CB92943514A0337014C1D9561@SW-EX-MBX01.diasemi.com>
References: <20180313170922.2fa1ea99@canb.auug.org.au>
In-Reply-To: <20180313170922.2fa1ea99@canb.auug.org.au>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.20.24.43]
x-kse-attachmentfiltering-interceptor-info: protection disabled
x-kse-serverinfo: sw-ex-cashub01.diasemi.com, 9
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: Clean, bases: 13/03/2018 04:00:00
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13 March 2018 06:09, Stephen Rothwell wrote:

> Hi all,
> 
> After merging the sound-asoc tree, today's linux-next build (powerpc
> allyesconfig) failed like this:
> 
> sound/soc/codecs/da7219.o: In function `.da7219_remove':
> da7219.c:(.text+0xcbc): undefined reference to `.clkdev_drop'
> 
> Caused by commit
> 
>   fc8f7ea2d6c0 ("ASoC: da7219: Add common clock usage for providing DAI clks")
> 
> CONFIG_CLKDEV_LOOKUP is not set for this build.
> 
> I have reverted that commit for today.

My bad. Apologies for this. :(

Mark, I'll send a follow up patch to fix this ASAP.
