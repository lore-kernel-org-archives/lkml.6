Return-Path: <geert.uytterhoeven@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519123124; cv=none;
        d=google.com; s=arc-20160816;
        b=tFcgwgIs/p3buZ/fZTIWjm8bdsfGwWPSFcgcdgtfuMbLD37wNTtMNs25iH1MaDneXK
         OFKpz7J6kBk/vAWDt0dIPVbzYGPi3PYJahT/i5eE3/Zoj6udkg2WOWFDg8p2Wo5P4Npy
         j+8LwyboyxaMS+7aSWYVmXZpjwURneeT8BatcDZblBfH5a3gfYcrEWBKEFp+CHb+ToL4
         C4UFq/H5Kvs/vRJ275Rw/u5HGTQbXNqONu0GoXgI524E/CaGTZ7y0YabbFn04xcEn+3s
         s4/nxmYpn/9ddCZwzTEIMb0j2bnXPDwrsee/liTclSyXOQbQJ20011HwOPKBorHaMK1x
         fLZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=n7l29ItlHzcG3+j3M+ceVrBIpqG0XJziEBZB9gWq3Jo=;
        b=cQIZSgdykydiZodTy8I0BUwsl2+DFDCH6L6FfAv/wya7f4Of9GcC9Y1VP316zTSePH
         G+fhrbqhY0MS4HL7uWLHwHDk0Om2B6s2mwYC6u9eZNXC+94rF70AkT79UglX80HnJMB6
         vdzOCGSgk+4opqKDVfGzoQ9ycAQajB5AWrGPvXSdrGoY0lqiDaRpT72w8WueQdeTG5fk
         iRLDRm8vHnflAAsLGmWYOvlmIngG+ZN3OPfrV3yHCV7KnxBZqxGTNYVPpRljGywUNkAm
         wHuJjIjiASYl0+pLKJaD34k8zWXDL2Fr9ZRyCIQ31+OHoht/75koHfYnRcOENeomj/W6
         GISQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Io4PbqI3;
       spf=pass (google.com: domain of geert.uytterhoeven@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=geert.uytterhoeven@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Io4PbqI3;
       spf=pass (google.com: domain of geert.uytterhoeven@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=geert.uytterhoeven@gmail.com
X-Google-Smtp-Source: AH8x225B1UjrTXpEtMKeb3qW5YAl0R4hIp+6G4c+FmdUgtrVXw4Ei+WBJSA4EX+RO+uMBRm5otuHgGUlGocd6ymSeyQ=
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <c16b025a-a302-8515-2697-f7eca478e939@xilinx.com>
References: <1519119624-1268-1-git-send-email-geert+renesas@glider.be>
 <1519119624-1268-10-git-send-email-geert+renesas@glider.be> <c16b025a-a302-8515-2697-f7eca478e939@xilinx.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 20 Feb 2018 11:38:43 +0100
X-Google-Sender-Auth: unedZQ971nsjlDak3AxvW7m8Tjk
Message-ID: <CAMuHMdUOKMM5mSrnnrxCi0gX_TbjYkj7vwn11b2D5p7XigM+Ag@mail.gmail.com>
Subject: Re: [PATCH 9/9] serial: xuartps: Fix out-of-bounds access through DT alias
To: Michal Simek <michal.simek@xilinx.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Barry Song <baohua@kernel.org>,
	Vineet Gupta <vgupta@synopsys.com>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
	arcml <linux-snps-arc@lists.infradead.org>,
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>, linux-arm-kernel@lists.infradead.org,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592913450163436302?=
X-GMAIL-MSGID: =?utf-8?q?1592916049663500075?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Michal,

On Tue, Feb 20, 2018 at 11:22 AM, Michal Simek <michal.simek@xilinx.com> wrote:
> On 20.2.2018 10:40, Geert Uytterhoeven wrote:
>> The cdns_uart_port[] array is indexed using a value derived from the
>> "serialN" alias in DT, which may lead to an out-of-bounds access.
>>
>> Fix this by adding a range check.
>>
>> Fixes: 1f118c02a1819856 ("serial: xuartps: Fix out-of-bounds access through DT alias")
>
> I didn't find this sha1 - patch name is this one.

Bummer, I totally screwed up my scripting...

Fixes: 928e9263492069ee ("tty: xuartps: Initialize ports according to aliases")

>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> ---
>>  drivers/tty/serial/xilinx_uartps.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
>> index b9b2bc76bcac606c..abcb4d09a2d866d0 100644
>> --- a/drivers/tty/serial/xilinx_uartps.c
>> +++ b/drivers/tty/serial/xilinx_uartps.c
>> @@ -1110,7 +1110,7 @@ static struct uart_port *cdns_uart_get_port(int id)
>>       struct uart_port *port;
>>
>>       /* Try the given port id if failed use default method */
>> -     if (cdns_uart_port[id].mapbase != 0) {
>> +     if (id < CDNS_UART_NR_PORTS && cdns_uart_port[id].mapbase != 0) {
>>               /* Find the next unused port */
>>               for (id = 0; id < CDNS_UART_NR_PORTS; id++)
>>                       if (cdns_uart_port[id].mapbase == 0)
>>
>
> Below should be better fix for this driver.

I considered that, too, but...

> --- a/drivers/tty/serial/xilinx_uartps.c
> +++ b/drivers/tty/serial/xilinx_uartps.c
> @@ -1109,6 +1109,9 @@ static struct uart_port *cdns_uart_get_port(int id)
>  {
>         struct uart_port *port;
>
> +       if (id >= CDNS_UART_NR_PORTS)
> +               return NULL;
> +
>         /* Try the given port id if failed use default method */
>         if (cdns_uart_port[id].mapbase != 0) {
>                 /* Find the next unused port */
> @@ -1117,9 +1120,6 @@ static struct uart_port *cdns_uart_get_port(int id)
>                                 break;
>         }
>
> -       if (id >= CDNS_UART_NR_PORTS)
> -               return NULL;
> -

... the above check cannot be removed, as it is needed to support the loop
above to find an unused port.

>         port = &cdns_uart_port[id];
>
>         /* At this point, we've got an empty uart_port struct,
> initialize it */

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
