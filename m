Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3247740-1526418008-2-10073070918097273631
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.248, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES enro, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: cc='UTF-8', plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526418006; b=UNuKxUBGD7nwRswAR/YIlz3ZRcLSWr0T+NLX9uZTgoRt5mj7uN
    ljeY+wk3mwFO2+jdetR/O3FW8G1uesdksv5xOsfTCl8hbQ8l2IauCmdo5Ocvqzwx
    vX/c93RdQWVu+ojarRoKFM3xtXqnggspazdzMF+qMZRlR+FngGfnq5q5id0CBsx7
    pWIHnUopMg55MfKFkBOGiWE2AZR7Baq86VkcVTAQ0iO4mLkU4nv4SasaDS6VYY+n
    +4kCzEhELt0VU1+afHD64AR6WF9oEFV7DzvcOJFAZYvdTxJVsLsvzqUAFLmtU/vr
    2OP0ZHzAS4b7nzkfCc538o93PDzV6hOLV54w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1526418006; bh=cLlY22ESvJaOCIAULADMJqcqMUP8nN1iL1sSBt9LOr
    8=; b=j8BbLcYdO7oMflD/oBcZ6L012HdJiHoo3RfExTahvhdOj/7Hqk7RF2vtoy
    JckLC6nrnLWOOtjXGSBW6khYvrv8WHlgDzQIQbspH7ymL9JfJiMhgXrCGc01waq1
    1F9ZxTANGU9fil9Ye8zJiAf9Z03Y3Pz0rc55l7IbhgxjJ7Z7eSKSYU9PdChp7nZZ
    8HillKy8hUmNrxylulnhquNqZksxfuIp93jafHyerHbqwkOfpGk8V11Gni7g/YMf
    gDBccrxF9mDSnOY/SKSF7cMt5Kut5W2rTRggxaud3ZzpPFnnhi7jsT1/flzIRS36
    CcBt6+2DsKqgyxpfFi1KpYmyv6qA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=KkZV71Z5 x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=g26weBzA;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=KkZV71Z5 x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=g26weBzA;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfB+h4DK2QGqzQBYlpKIB7qHvjbpnttTzzX4DfJRaU/Y5L5jPesP+s8pGR2XnrtVkDI0ngXeEKA6DFUdKJd34CEsdwuyj4uCiygjQF7q+vG2OaIgQq64W
    v6E9KUjOe5yt3KLo775EskPr13Ji5S+cE2ZMa15gyOCK/zMo9CEbtNuU9B1AUjGGxfNb8EM3mU3w1+AigTGn4lDrYlMLXe9V0ZUlucsSiGisVIUPQzXffRA3
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=x7bEGLp0ZPQA:10
    a=fbV3Th2LUxsA:10 a=VUJBJC2UJ8kA:10 a=CbDCq_QkAAAA:8 a=VwQbUJbxAAAA:8
    a=k8P3tP1lSa7KgEOYO4YA:9 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=1qrBK16LubpBFNPVNq2M:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752452AbeEOVAE (ORCPT <rfc822;greg@kroah.com>);
        Tue, 15 May 2018 17:00:04 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:35512 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752354AbeEOVAC (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 15 May 2018 17:00:02 -0400
X-Google-Smtp-Source: AB8JxZrD4Esbm1ML4OnAxPQQHZJYl0aABKNU+3XNC+goOlYX2uVghu+yw/9nq7zuMgkdzDE62KbgTYBA4nhqj3BQZCk=
MIME-Version: 1.0
In-Reply-To: <1526394095-5069-3-git-send-email-oleksandrs@mellanox.com>
References: <1526394095-5069-1-git-send-email-oleksandrs@mellanox.com> <1526394095-5069-3-git-send-email-oleksandrs@mellanox.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 16 May 2018 00:00:00 +0300
Message-ID: <CAHp75Ve7EYiWBiE73i0CmyJhPMOdSKsGzCr0SUvta3Uya=Ov1Q@mail.gmail.com>
Subject: Re: [patch v21 2/4] drivers: jtag: Add Aspeed SoC 24xx and 25xx
 families JTAG master driver
To: Oleksandr Shamray <oleksandrs@mellanox.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        openbmc@lists.ozlabs.org, Joel Stanley <joel@jms.id.au>,
        =?UTF-8?B?SmnFmcOtIFDDrXJrbw==?= <jiri@resnulli.us>,
        Tobias Klauser <tklauser@distanz.ch>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Vadim Pasternak <vadimp@mellanox.com>,
        system-sw-low-level@mellanox.com, Rob Herring <robh+dt@kernel.org>,
        openocd-devel-owner@lists.sourceforge.net,
        linux-api@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jiri Pirko <jiri@mellanox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 15, 2018 at 5:21 PM, Oleksandr Shamray
<oleksandrs@mellanox.com> wrote:
> Driver adds support of Aspeed 2500/2400 series SOC JTAG master controller.
>
> Driver implements the following jtag ops:
> - freq_get;
> - freq_set;
> - status_get;
> - idle;
> - xfer;
>
> It has been tested on Mellanox system with BMC equipped with
> Aspeed 2520 SoC for programming CPLD devices.

> +#define ASPEED_JTAG_DATA               0x00
> +#define ASPEED_JTAG_INST               0x04
> +#define ASPEED_JTAG_CTRL               0x08
> +#define ASPEED_JTAG_ISR                        0x0C
> +#define ASPEED_JTAG_SW                 0x10
> +#define ASPEED_JTAG_TCK                        0x14
> +#define ASPEED_JTAG_EC                 0x18
> +
> +#define ASPEED_JTAG_DATA_MSB           0x01
> +#define ASPEED_JTAG_DATA_CHUNK_SIZE    0x20


> +#define ASPEED_JTAG_IOUT_LEN(len)      (ASPEED_JTAG_CTL_ENG_EN |\
> +                                        ASPEED_JTAG_CTL_ENG_OUT_EN |\
> +                                        ASPEED_JTAG_CTL_INST_LEN(len))

Better to read

#define MY_COOL_CONST_OR_MACRO(xxx) \
 ...

> +#define ASPEED_JTAG_DOUT_LEN(len)      (ASPEED_JTAG_CTL_ENG_EN |\
> +                                        ASPEED_JTAG_CTL_ENG_OUT_EN |\
> +                                        ASPEED_JTAG_CTL_DATA_LEN(len))

Ditto.

> +static char *end_status_str[] = {"idle", "ir pause", "drpause"};

> +static int aspeed_jtag_freq_set(struct jtag *jtag, u32 freq)
> +{
> +       struct aspeed_jtag *aspeed_jtag = jtag_priv(jtag);
> +       unsigned long apb_frq;
> +       u32 tck_val;
> +       u16 div;
> +
> +       apb_frq = clk_get_rate(aspeed_jtag->pclk);

> +       div = (apb_frq % freq == 0) ? (apb_frq / freq) - 1 : (apb_frq / freq);

Isn't it the same as

div = (apb_frq - 1) / freq;

?

> +       tck_val = aspeed_jtag_read(aspeed_jtag, ASPEED_JTAG_TCK);
> +       aspeed_jtag_write(aspeed_jtag,
> +                         (tck_val & ASPEED_JTAG_TCK_DIVISOR_MASK) | div,
> +                         ASPEED_JTAG_TCK);
> +       return 0;
> +}

> +static void aspeed_jtag_sw_delay(struct aspeed_jtag *aspeed_jtag, int cnt)
> +{
> +       int i;
> +
> +       for (i = 0; i < cnt; i++)
> +               aspeed_jtag_read(aspeed_jtag, ASPEED_JTAG_SW);

Isn't it readsl() (or how it's called, I don't remember).

> +}

> +static void aspeed_jtag_wait_instruction_pause(struct aspeed_jtag *aspeed_jtag)
> +{
> +       wait_event_interruptible(aspeed_jtag->jtag_wq, aspeed_jtag->flag &
> +                                ASPEED_JTAG_ISR_INST_PAUSE);

In such cases I prefer to see a new line with a parameter in full.
Check all places.

> +       aspeed_jtag->flag &= ~ASPEED_JTAG_ISR_INST_PAUSE;
> +}

> +static void aspeed_jtag_sm_cycle(struct aspeed_jtag *aspeed_jtag, const u8 *tms,
> +                                int len)
> +{
> +       int i;
> +
> +       for (i = 0; i < len; i++)
> +               aspeed_jtag_tck_cycle(aspeed_jtag, tms[i], 0);
> +}
> +
> +static void aspeed_jtag_run_test_idle_sw(struct aspeed_jtag *aspeed_jtag,
> +                                        struct jtag_run_test_idle *runtest)
> +{
> +       static const u8 sm_pause_irpause[] = {1, 1, 1, 1, 0, 1, 0};
> +       static const u8 sm_pause_drpause[] = {1, 1, 1, 0, 1, 0};
> +       static const u8 sm_idle_irpause[] = {1, 1, 0, 1, 0};
> +       static const u8 sm_idle_drpause[] = {1, 0, 1, 0};
> +       static const u8 sm_pause_idle[] = {1, 1, 0};
> +       int i;
> +
> +       /* SW mode from idle/pause-> to pause/idle */
> +       if (runtest->reset) {
> +               for (i = 0; i < ASPEED_JTAG_RESET_CNTR; i++)
> +                       aspeed_jtag_tck_cycle(aspeed_jtag, 1, 0);
> +       }

I would rather split this big switch to a few helper functions per
each status of surrounding switch.

> +
> +       /* Stay on IDLE for at least  TCK cycle */
> +       for (i = 0; i < runtest->tck; i++)
> +               aspeed_jtag_tck_cycle(aspeed_jtag, 0, 0);
> +}


> +/**
> + * aspeed_jtag_run_test_idle:
> + * JTAG reset: generates at least 9 TMS high and 1 TMS low to force
> + * devices into Run-Test/Idle State.
> + */

It's rather broken kernel doc.

> +               aspeed_jtag_write(aspeed_jtag, ASPEED_JTAG_CTL_ENG_EN |
> +                                 ASPEED_JTAG_CTL_ENG_OUT_EN |
> +                                 ASPEED_JTAG_CTL_FORCE_TMS, ASPEED_JTAG_CTRL);

> +               aspeed_jtag_write(aspeed_jtag, ASPEED_JTAG_EC_GO_IDLE,
> +                                 ASPEED_JTAG_EC);

> +       aspeed_jtag_write(aspeed_jtag, ASPEED_JTAG_SW_MODE_EN |
> +                         ASPEED_JTAG_SW_MODE_TDIO, ASPEED_JTAG_SW);

Here you have permutations of flag some of which are repeatetive in
the code. Perhaps make additional definitions instead.
Check other similar places.


> +       char          tdo;

Indentation.

> +       if (xfer->direction == JTAG_READ_XFER)
> +               tdi = UINT_MAX;
> +       else
> +               tdi = data[index];

> +                       if (xfer->direction == JTAG_READ_XFER)
> +                               tdi = UINT_MAX;
> +                       else
> +                               tdi = data[index];

Take your time to think how the above duplication can be avoided.

> +               }
> +       }
> +
> +       tdo = aspeed_jtag_tck_cycle(aspeed_jtag, 1, tdi & ASPEED_JTAG_DATA_MSB);
> +       data[index] |= tdo << (shift_bits % ASPEED_JTAG_DATA_CHUNK_SIZE);
> +}


> +       if (endstate != JTAG_STATE_IDLE) {

Why not to use positive check?

> +       int i;
> +
> +       for (i = 0; i <= xfer->length / BITS_PER_BYTE; i++) {
> +               pos += snprintf(&dbg_str[pos], sizeof(dbg_str) - pos,
> +                               "0x%02x ", xfer_data[i]);
> +       }

Oh, NO! Consider reading printk-formats (for %*ph) and other
documentation about available APIs.

> +       if (!(aspeed_jtag->mode & JTAG_XFER_HW_MODE)) {
> +               /* SW mode */

This is rather too complex to be in one function.

> +       } else {

> +               /* hw mode */
> +               aspeed_jtag_write(aspeed_jtag, 0, ASPEED_JTAG_SW);
> +               aspeed_jtag_xfer_hw(aspeed_jtag, xfer, data);

For symmetry it might be another function.

> +       }

> +       dev_dbg(aspeed_jtag->dev, "status %x\n", status);

Perhaps someone should become familiar with tracepoints?

> +               dev_err(aspeed_jtag->dev, "irq status:%x\n",
> +                       status);


Huh, really?! SPAM.

(I would drop it completely, though you may use ratelimited variant)

> +               ret = IRQ_NONE;
> +       }
> +       return ret;
> +}

> +       clk_prepare_enable(aspeed_jtag->pclk);

This might fail.

> +       dev_dbg(&pdev->dev, "IRQ %d.\n", aspeed_jtag->irq);

Noise even for debug.

> +       err = jtag_register(jtag);

Perhaps we might have devm_ variant of this. Check how SPI framework
deal with a such.

> +static int aspeed_jtag_remove(struct platform_device *pdev)
> +{

> +       struct jtag *jtag;
> +
> +       jtag = platform_get_drvdata(pdev);

Usually we put this on one line

> +       aspeed_jtag_deinit(pdev, jtag_priv(jtag));
> +       jtag_unregister(jtag);
> +       jtag_free(jtag);
> +       return 0;
> +}


-- 
With Best Regards,
Andy Shevchenko
