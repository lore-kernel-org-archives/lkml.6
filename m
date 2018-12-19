Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5074DC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 00:52:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 182B12080D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 00:52:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727176AbeLSAww (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 19:52:52 -0500
Received: from mail-out.m-online.net ([212.18.0.10]:51245 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726704AbeLSAww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 19:52:52 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 43KGZl34ZGz1qxJV;
        Wed, 19 Dec 2018 01:52:47 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 43KGZl0czLz1qstF;
        Wed, 19 Dec 2018 01:52:47 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id p_ITxdhnlddH; Wed, 19 Dec 2018 01:52:45 +0100 (CET)
X-Auth-Info: SygMuPJdcDDgj4NzomDDkYcRzDyyuT7DUkCZwdEoMpM=
Received: from [IPv6:::1] (unknown [195.140.253.167])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Wed, 19 Dec 2018 01:52:45 +0100 (CET)
Subject: Re: [PATCH] Revert "serial: 8250: Fix clearing FIFOs in RS485 mode
 again"
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Paul Burton <paul.burton@mips.com>
Cc:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Paul Burton <pburton@wavecomp.com>,
        Daniel Jedrychowski <avistel@gmail.com>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Ezequiel Garcia <ezequiel@collabora.com>
References: <20181213174834.kxdy6fphaeoivqgh@pburton-laptop>
 <20181216200833.27928-1-paul.burton@mips.com>
 <f5a76d73-862f-3ebc-cd07-effc5c432103@denx.de>
 <20181216213133.kwe24pif3v4wcgwp@pburton-laptop>
 <949fdd3d-535e-d235-f406-d5bde4658c5e@denx.de>
 <CAAEAJfAad75bHX39ETCdVv9vP0dF7PLz2vvFLLqgtyikPHqJyA@mail.gmail.com>
 <20181216222411.5jkexuaqxpfudj7b@pburton-laptop>
 <CAAEAJfAQ9=B6sm=Ard+YTDN5g5r03o=t9xU3Nu2QaKrXXZ4pGw@mail.gmail.com>
 <20181216223510.hxsdotf332ousinh@pburton-laptop>
 <CAAEAJfDHvGTPN9u4zwWRFvK1WmpLmz87CjsjzmyhcExTGHQPmA@mail.gmail.com>
 <61a3177f-4e8d-fc51-1e81-95af3baab3a8@denx.de>
From:   Marek Vasut <marex@denx.de>
Message-ID: <3086d1b7-9ed9-9d48-4371-89139c356d22@denx.de>
Date:   Wed, 19 Dec 2018 01:12:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <61a3177f-4e8d-fc51-1e81-95af3baab3a8@denx.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/17/2018 06:20 PM, Marek Vasut wrote:
> On 12/17/2018 05:30 PM, Ezequiel Garcia wrote:
>> On Sun, 16 Dec 2018 at 19:35, Paul Burton <paul.burton@mips.com> wrote:
>>>
>>> Hi Ezequiel,
>>>
>>> On Sun, Dec 16, 2018 at 07:28:22PM -0300, Ezequiel Garcia wrote:
>>>> On Sun, 16 Dec 2018 at 19:24, Paul Burton <paul.burton@mips.com> wrote:
>>>>> This helps, but it only addresses one part of one of the 4 reasons I
>>>>> listed as motivation for my revert. For example serial8250_do_shutdown()
>>>>> also clearly intends to disable the FIFOs.
>>>>>
>>>>
>>>> OK. So, let's fix that :-)
>>>
>>> I already did, or at least tried to, on Thursday [1].
>>>
>>>> By all means, it would be really nice to push forward and fix the garbage
>>>> issue on JZ4780, as well as the transmission issue on AM335x.
>>>>
>>>> AM335x is a wildly popular platform, and it's not funny to break it.
>>>
>>> Well, clearly not if it was broken in v4.10 & only just fixed..? And
>>> from Marek's commit message the patch in v4.10 doesn't break the whole
>>> system just RS485.
>>>
>>
>> Careful here. It's naive to consider v4.10 as old in this context.
>>
>> AM335x is used in hundreds of thousands of products, probably
>> "industrial" products.
>> Manufacturers don't always follow the kernel, and it's entirely
>> likely that they notice a regression only when developing a new product,
>> or when rebasing on top of a newer longterm kernel.
>>
>> Then again, I don't have any details about what is Marek's original fix
>> actually fixing.
>>
>> Marek: could you please post the test case that you used to validate your fix?
>> I can't find that anywhere.
> 
> I can't share the testcase itself because it has no license and I didn't
> write it, but I can tell you what it's doing. (I'll check if I can share
> the testcase verbatim too, I just sent an email to the author)
> 
> The test spawns two threads, one sending , one receiving. The sending
> thread sends 8 bytes of data from /dev/ttyS4 , the receiving thread
> receives the data on /dev/ttyS2 and compares the pattern. The port
> settings is B1000000 8N1 with rs485conf.flags set to SER_RS485_ENABLED
> and SER_RS485_RTS_AFTER_SEND. Sometimes the received data do not match
> the sent data, but rather look as if one character was left over from
> the previous transmission in the FIFO.
> 
> Those two UARTs are connected together by two wires, without any real
> RS485 hardware to minimize the hardware complexity (it's easy to
> implement that on the pocketbeagle, which is the cheap option here).

Test code is below . On the pocketbeagle, connect SPI0:CLK with U4:TX
and SPI0:MISO with U4:RX , apply the DT patch below and run the example.
It'll fail after a few iterations.

#include <errno.h>
#include <fcntl.h>
#include <string.h>
#include <termios.h>
#include <unistd.h>

#include <iostream>
#include <iomanip>
#include <atomic>
#include <thread>

#include <linux/serial.h>
#include <sys/ioctl.h>

std::atomic<bool> running{true};

int set_interface_attribs (int fd, int speed, int parity)
{
        struct termios tty;
        memset (&tty, 0, sizeof tty);
        if (tcgetattr (fd, &tty) != 0)
        {
                std::cerr << "Error from tcgetattr" << std::endl;
                return -1;
        }

        cfsetospeed (&tty, speed);
        cfsetispeed (&tty, speed);

        tty.c_cflag = (tty.c_cflag & ~CSIZE) | CS8;
        tty.c_iflag &= ~IGNBRK;
        tty.c_lflag = 0;

        tty.c_oflag = 0;
        tty.c_cc[VMIN]  = 8;
        tty.c_cc[VTIME] = 0;

        tty.c_iflag &= ~(IXON | IXOFF | IXANY);

        tty.c_cflag |= (CLOCAL | CREAD);
        tty.c_cflag &= ~(PARENB | PARODD);
        tty.c_cflag |= parity;
        tty.c_cflag &= ~CSTOPB;
        tty.c_cflag &= ~CRTSCTS;

        if (tcsetattr (fd, TCSANOW, &tty) != 0)
        {
                std::cerr << "Error from tcsetattr" << std::endl;
                return -1;
        }
        return 0;
}

void enable_rts(int fd, int rts)
{
     struct serial_rs485 rs485conf;
      if (rts) {
              rs485conf.flags = SER_RS485_ENABLED ;
              rs485conf.flags |= SER_RS485_RTS_AFTER_SEND;
              rs485conf.flags &= ~(SER_RS485_RTS_ON_SEND);
              rs485conf.delay_rts_before_send = 0;
              rs485conf.delay_rts_after_send = 0;
      } else {
              rs485conf.flags = 0 ;
      }

      if (ioctl( fd, TIOCSRS485, &rs485conf) < 0){
          std::cerr << "Cannot set device in RS485 mode" << std::endl;
      }
}

void output_function(int fd)
{
   while(running) {
    write (fd, "asdfghjk", 8);
    usleep (20000);
   }
}

void input_function(int fd)
{
  char buf [100];
  size_t count=0;
  std::cout << std::unitbuf;
  while(running){
    int n = read (fd, buf, sizeof buf);
    if( (n >0) && (buf[0] != 'a') ){
        std::cout << "\nunexpected receive! " << std::string(buf,8) <<
std::endl;
        running = false;
    } else {
       ++count;
       if(count%100 == 0){
          std::cout << "\r" << std::setw(8) << count << " possibly ok";
       }
    }
  }
}

int main(int argc, char** argv)
{
  std::string in_port  = "/dev/ttyS2";
  std::string out_port = "/dev/ttyS4";

  int c, rts = 1;

  while ((c = getopt (argc, argv, "i:o:r")) != -1)
  {
    switch (c)
      {
      case 'i':
        in_port = std::string(optarg);
        break;
      case 'o':
        out_port = std::string(optarg);
        break;
      case 'r':
        rts = 0;
        break;
      case '?':
        return 1;
      default:
        break;
      }
    }

    std::cout << "opening output " << out_port << std::endl;
    int outfd = open ( out_port.c_str(), O_RDWR | O_NOCTTY | O_SYNC);
    if (outfd < 0)
    {
            std::cerr << "Could not open " << out_port << std::endl;
            return 1;
    }

    std::cout << "opening input " << in_port << std::endl;
    int infd = open ( in_port.c_str(), O_RDWR | O_NOCTTY | O_SYNC);
    if (infd < 0)
    {
            std::cerr << "Could not open " << in_port << std::endl;
            return 1;
    }

    set_interface_attribs (infd,  B1000000, 0);
    set_interface_attribs (outfd, B1000000, 0);

    enable_rts(outfd, rts);
    enable_rts(infd, rts);

    std::thread in(input_function, infd);
    std::thread out(output_function, outfd);

    in.join();
    out.join();

    close(infd);
    close(outfd);
}

diff --git a/arch/arm/boot/dts/am335x-pocketbeagle.dts
b/arch/arm/boot/dts/am335x-pocketbeagle.dts
index 62fe5cab9fae..d9b8f09920a6 100644
--- a/arch/arm/boot/dts/am335x-pocketbeagle.dts
+++ b/arch/arm/boot/dts/am335x-pocketbeagle.dts
@@ -92,15 +92,6 @@
                >;
        };

-       spi0_pins: pinmux-spi0-pins {
-               pinctrl-single,pins = <
-                       AM33XX_IOPAD(0x950, PIN_INPUT_PULLUP |
MUX_MODE0)       /* (A17) spi0_sclk.spi0_sclk */
-                       AM33XX_IOPAD(0x954, PIN_INPUT_PULLUP |
MUX_MODE0)       /* (B17) spi0_d0.spi0_d0 */
-                       AM33XX_IOPAD(0x958, PIN_INPUT_PULLUP |
MUX_MODE0)       /* (B16) spi0_d1.spi0_d1 */
-                       AM33XX_IOPAD(0x95c, PIN_INPUT_PULLUP |
MUX_MODE0)       /* (A16) spi0_cs0.spi0_cs0 */
-               >;
-       };
-
        spi1_pins: pinmux-spi1-pins {
                pinctrl-single,pins = <
                        AM33XX_IOPAD(0x964, PIN_INPUT_PULLUP |
MUX_MODE4)       /* (C18) eCAP0_in_PWM0_out.spi1_sclk */
@@ -126,6 +117,13 @@
                >;
        };

+       uart2_pins: pinmux-uart2-pins {
+               pinctrl-single,pins = <
+                       AM33XX_IOPAD(0x950, PIN_INPUT | MUX_MODE1)
       /* spi0_sclk.uart2_rxd */
+                       AM33XX_IOPAD(0x954, PIN_OUTPUT | MUX_MODE1)
       /* spi0_d0.uart2_txd */
+               >;
+       };
+
        uart4_pins: pinmux-uart4-pins {
                pinctrl-single,pins = <
                        AM33XX_IOPAD(0x870, PIN_INPUT_PULLUP |
MUX_MODE6)       /* (T17) gpmc_wait0.uart4_rxd */
@@ -199,6 +197,13 @@
        status = "okay";
 };

+&uart2 {
+       pinctrl-names = "default";
+       pinctrl-0 = <&uart2_pins>;
+
+       status = "okay";
+};
+
 &uart4 {
        pinctrl-names = "default";
        pinctrl-0 = <&uart4_pins>;

-- 
Best regards,
Marek Vasut
