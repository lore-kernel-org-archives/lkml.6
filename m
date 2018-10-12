Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B8B0C6787C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 20:23:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE1FF205F4
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 20:23:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE1FF205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbeJMD5w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 23:57:52 -0400
Received: from mout.gmx.net ([212.227.17.22]:54095 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726227AbeJMD5w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 23:57:52 -0400
Received: from [192.168.20.60] ([92.116.158.110]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Le69A-1fsZ941ANA-00priv; Fri, 12
 Oct 2018 22:23:30 +0200
Received: from [192.168.20.60] ([92.116.158.110]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Le69A-1fsZ941ANA-00priv; Fri, 12
 Oct 2018 22:23:30 +0200
Subject: Re: [PATCH v4 5/6] parisc: wire up rseq system call
To:     Arnd Bergmann <arnd@arndb.de>, Firoz Khan <firoz.khan@linaro.org>
Cc:     Parisc List <linux-parisc@vger.kernel.org>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        gregkh <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
References: <1539337442-3676-1-git-send-email-firoz.khan@linaro.org>
 <1539337442-3676-6-git-send-email-firoz.khan@linaro.org>
 <CAK8P3a1gsuM7mBGm9hx-BTs=HAG3cSjB6M7N-kpMmPy3kixeCQ@mail.gmail.com>
 <CALxhOnhj7qUj57tLX12KmbcE5G-zDK2Qf2fTUbQ=jpmiUcr52w@mail.gmail.com>
 <CAK8P3a3BjuLQh0hTPFTDTkipXXQ+j8ADqbWmNpimkMDzoORkRA@mail.gmail.com>
From:   Helge Deller <deller@gmx.de>
Openpgp: preference=signencrypt
Autocrypt: addr=deller@gmx.de; prefer-encrypt=mutual; keydata=
 xsBNBFDPIPYBCAC6PdtagIE06GASPWQJtfXiIzvpBaaNbAGgmd3Iv7x+3g039EV7/zJ1do/a
 y9jNEDn29j0/jyd0A9zMzWEmNO4JRwkMd5Z0h6APvlm2D8XhI94r/8stwroXOQ8yBpBcP0yX
 +sqRm2UXgoYWL0KEGbL4XwzpDCCapt+kmarND12oFj30M1xhTjuFe0hkhyNHkLe8g6MC0xNg
 KW3x7B74Rk829TTAtj03KP7oA+dqsp5hPlt/hZO0Lr0kSAxf3kxtaNA7+Z0LLiBqZ1nUerBh
 OdiCasCF82vQ4/y8rUaKotXqdhGwD76YZry9AQ9p6ccqKaYEzWis078Wsj7p0UtHoYDbABEB
 AAHNHEhlbGdlIERlbGxlciA8ZGVsbGVyQGdteC5kZT7CwJIEEwECADwCGwMGCwkIBwMCBhUI
 AgkKCwQWAgMBAh4BAheAFiEE9M/0wAvkPPtRU6Boh8nBUbUeOGQFAlrHzIICGQEACgkQh8nB
 UbUeOGT1GAgAt+EeoHB4DbAx+pZoGbBYp6ZY8L6211n8fSi7wiwgM5VppucJ+C+wILoPkqiU
 +ZHKlcWRbttER2oBUvKOt0+yDfAGcoZwHS0P+iO3HtxR81h3bosOCwek+TofDXl+TH/WSQJa
 iaitof6iiPZLygzUmmW+aLSSeIAHBunpBetRpFiep1e5zujCglKagsW78Pq0DnzbWugGe26A
 288JcK2W939bT1lZc22D9NhXXRHfX2QdDdrCQY7UsI6g/dAm1d2ldeFlGleqPMdaaQMcv5+E
 vDOur20qjTlenjnR/TFm9tA1zV+K7ePh+JfwKc6BSbELK4EHv8J8WQJjfTphakYLVM7ATQRQ
 zyD2AQgA2SJJapaLvCKdz83MHiTMbyk8yj2AHsuuXdmB30LzEQXjT3JEqj1mpvcEjXrX1B3h
 +0nLUHPI2Q4XWRazrzsseNMGYqfVIhLsK6zT3URPkEAp7R1JxoSiLoh4qOBdJH6AJHex4CWu
 UaSXX5HLqxKl1sq1tO8rq2+hFxY63zbWINvgT0FUEME27Uik9A5t8l9/dmF0CdxKdmrOvGMw
 T770cTt76xUryzM3fAyjtOEVEglkFtVQNM/BN/dnq4jDE5fikLLs8eaJwsWG9k9wQUMtmLpL
 gRXeFPRRK+IT48xuG8rK0g2NOD8aW5ThTkF4apznZe74M7OWr/VbuZbYW443QQARAQABwsBf
 BBgBAgAJBQJQzyD2AhsMAAoJEIfJwVG1HjhkNTgH/idWz2WjLE8DvTi7LvfybzvnXyx6rWUs
 91tXUdCzLuOtjqWVsqBtSaZynfhAjlbqRlrFZQ8i8jRyJY1IwqgvHP6PO9s+rIxKlfFQtqhl
 kR1KUdhNGtiI90sTpi4aeXVsOyG3572KV3dKeFe47ALU6xE5ZL5U2LGhgQkbjr44I3EhPWc/
 lJ/MgLOPkfIUgjRXt0ZcZEN6pAMPU95+u1N52hmqAOQZvyoyUOJFH1siBMAFRbhgWyv+YE2Y
 ZkAyVDL2WxAedQgD/YCCJ+16yXlGYGNAKlvp07SimS6vBEIXk/3h5Vq4Hwgg0Z8+FRGtYZyD
 KrhlU0uMP9QTB5WAUvxvGy8=
Message-ID: <71ea9dc5-7502-40af-2022-b2196dd2d690@gmx.de>
Date:   Fri, 12 Oct 2018 22:23:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <CAK8P3a3BjuLQh0hTPFTDTkipXXQ+j8ADqbWmNpimkMDzoORkRA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:gw2BrElVPRj3kCZ20TAt6HobxEiK5TMmMvbuDdQuU3GDIfsSuhK
 We4fav2S5YJqTTqe6Y4d2FX5Pnka+WidtQxMrjBA38QBNMzEx+8TozWhc0lNYgZShDGOFln
 VqapacWqF49Z02mlJZn4/7MFiJwcuSO2ndTonAkZdC8EWljVOK4auZuxd7eeuabKAwHXwir
 n8jv0I21tvqFkyNrPwjPw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:wXiX8htEITw=:oF6S8MznspJWnGbl2MBhcu
 Rg05u5r/ANiQlv/utq13PPvMptzZrDEt57lOeclZv2FHUXXcGE9SEl67fZ+cy0kbbrhyW2Tmn
 DTZOT71Tn2pzouQt7Xb+UYyqknimjFAtyZTqt/59c89IuK82fOh2EAOGFscaIPBSbEwDPXxrc
 oTvRQqr/00jOFUl8FWP/zBXQRNdYPHlm50JTdRp3BooqakKBdDK2mpPpliMHldHbf7WmAprCn
 HmU1/v0+02UN/pnRkbhNughahUDP8WyK2W+RvzPuFQghbGnj3U8oHcBa40A09bJK3jE68RMmq
 OzfBF0KdQtW2HFVmZyn3e6YMnlM0P07+tzcTy06EXY23HG9U12kcsq2dlhGlnsxlZUMQmhiaz
 omG9xyz2hLyKvYKftC+pP6tUkFz/7C3sXcgWvZFDz1kqXV5Kp5TnkTCTcjFJZ4BLtATgFWH6e
 KTq3efLwhg++nLCzJpnvhHIbratEmxakT3jgelbqGYIGXjyoVHqaIiqupebN3R0GwYn7Nq7AZ
 azLhA4M4TxqfZeYs+b1d0TQVXH4U5iJMWE2EYZaUg+EE6yD3A/mwwtPZBtW3ZJbg7KKS/v6bJ
 Q1dDJDemd4pgAYWPblXv9iP977doTXdxtBjZHYRhx37BoTf4MRF8k5C1JqgAQYPfHlA9cN3YL
 UiVA0wIYNvfzoTdeZY4epo+/9BKLQSZHpqC8nDRw68JeiYT/KMkpcf+nlciqsTzcr+0RCUpN2
 J3JumGu/PTEtxhYTkIM4iBzPki1IFXPhBkLEoQ2e10JZEUmoT0uzUH1qAdWXqZ49orelzIxbV
 o/2IH4p1yLOM2KTNGuhrPXjfF13swyg0GBA/NruEbs7DyGI4Rs=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.10.2018 13:52, Arnd Bergmann wrote:
> On Fri, Oct 12, 2018 at 12:16 PM Firoz Khan <firoz.khan@linaro.org> wrote:
>>
>> Hi Arnd,
>>
>> On Fri, 12 Oct 2018 at 15:26, Arnd Bergmann <arnd@arndb.de> wrote:
>>>
>>> On Fri, Oct 12, 2018 at 11:45 AM Firoz Khan <firoz.khan@linaro.org> wrote:
>>>>
>>>> Wire up rseq system call requires an architecture specific
>>>> implementation as it not present now.
>>>>
>>>> Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
>>>
>>> Didn't we conclude that this should be skipped?
>>
>> Helge told "I prefer to keep the warning for rseq for now.
>> It reminds me that we still may want the rseq syscall.
>> If the warning is a problem, you may simply add the __IGNORE_rseq define."
>>
>> I chose this option; I feel it looks clean
>> "# rseq requires an architecture specific implementation" in syscall.tbl
>> hopefully remind him to add rseq syscall implementation in this architecture.
> 
> But he said he wants the warning instead.

Correct.
Firoz, please simply drop this patch completely.
That way one will see generated warnings about the missing rseq (which is what
we want).

Thanks,
Helge
