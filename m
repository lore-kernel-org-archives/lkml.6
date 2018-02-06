Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752003AbeBFOHn convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 09:07:43 -0500
Received: from mout.gmx.net ([212.227.15.19]:61271 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751984AbeBFOHe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 09:07:34 -0500
Message-ID: <1517926038.25841.36.camel@gmx.de>
Subject: Re: [PATCH BUGFIX 1/1] block, bfq: add requeue-request hook
From: Mike Galbraith <efault@gmx.de>
To: Holger =?ISO-8859-1?Q?Hoffst=E4tte?=
        <holger@applied-asynchrony.com>,
        Paolo Valente <paolo.valente@linaro.org>
Cc: Oleksandr Natalenko <oleksandr@natalenko.name>,
        Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "'Paolo Valente' via bfq-iosched"
        <bfq-iosched@googlegroups.com>,
        Alban Browaeys <alban.browaeys@gmail.com>, ming.lei@redhat.com,
        ivan@ludios.org, 169364@studenti.unimore.it,
        Serena Ziviani <ziviani.serena@gmail.com>
Date: Tue, 06 Feb 2018 15:07:18 +0100
In-Reply-To: <7770589c-32e0-6bdb-530a-34c642e46630@applied-asynchrony.com>
References: <20180205190510.5499-1-paolo.valente@linaro.org>
         <20180205190510.5499-2-paolo.valente@linaro.org>
         <ee76e49c0d1ceab07c20e9d27e2fdc46@natalenko.name>
         <1517903761.9843.12.camel@gmx.de>
         <899B68CC-5955-4418-8BFF-DC55A743A61B@linaro.org>
         <1517918234.25841.31.camel@gmx.de>
         <BE442D49-D280-4B35-89ED-43C729263F2A@linaro.org>
         <7770589c-32e0-6bdb-530a-34c642e46630@applied-asynchrony.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.20.5 
Mime-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K0:buP6kh1ZDC9dZf6bGa2H3e0yXGpHLYItGUWtWHg0CewKaS8Vi8g
 2HP3oPLY0+8MVAo+IcmP/rm0Do06AdBkdBzehdZbyk6csckGa7hjbB9ocyzxPkb501p0gwB
 6qJKZqXxDJEdum34TD0cVCy5KmS8Vq2cvUt6591yiheZMwijXqzQ2p2s6XSEuXJEyjDHxUs
 dnrQyIcGbkYtp/lt5EN6Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:KrfAjvWaIjg=:ZSS2H64RprrT+BH275P8mt
 6klYSKhT0wIND2AJgEnAnExfi7gbBmvvwzH4902XV/CwKRjzKz2D3Thl8KP+AgN8ggO0zL2vj
 XbLrj88XOTbsEEujLumby3/M2VfM5ifX1ox/8mDgoJuGvyMDmdkfsOwhwhDMu+Rp8qRHvIlWN
 S8QDWuznk5dBgQimPdUjJcwsMKgJlh7GmYjGxl1buaZx6m2J2TY7IJna7oMrFUczrW2Wrpc3f
 FAtveywbo1bQsmLFjVsI8QKlH8qsrFcWp1gWZdeqkugjseBMS84S/87JbAiSs5A17yGYOODBA
 u9YITdcsSeuc3y4bpORih0tQlX3N/FlFyjB8pn/4ZUnxFORP0w1XXeuy4Cgb3hlaHM+fjj9JG
 aZWgP7gDBT8FSR8h+BtaO+4UvDPaUyvti9A6Azc9fuybvD1R1Fh6wqMKtwduVp4GTuH/oQ/q8
 pAPuUcYs9gML5OtzM2AZp4SeGb9Lt4vt5RwuYZiTaj66ohlLbTKIUWKHukguwHoOSaWvIK3gX
 VYraFszftESCImrNg0ZF0dFfSUxF9bpsn7vcUTHa49EkAlQ28EVI+5HTyXDHnq5QUvCttRHQq
 47UVxb/lKmsWHvmXkx2SeFuniXtg1v1MAIjQmL6gjMcWIzZHdUn9Au0V54LaE3gBPbZbHkE5n
 fOGBkwrroSOqUp+3P+ceqeFxP0Ahf4z+GEithx79w8mPvElWlwv2QuSmxBx2rvytE+6Z9lbId
 vmqrkOXibK6yCaB2/CXjPgzKR7p3qhlm31Rg0jxCyUT6JLXPkXIEFn3lxqhjjkWCxl0ikBQ9y
 lIzyqcz5JOiBTEbr+K52s1HWuRnCLR6sXt3Rw+kQvgeHsU1iGo=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-02-06 at 13:43 +0100, Holger Hoffstätte wrote:
> 
> A much more interesting question to me is why there is kyber in the middle. :)

Yeah, given per sysfs I have zero devices using kyber.

	-Mike
