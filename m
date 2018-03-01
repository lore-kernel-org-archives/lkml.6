Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031437AbeCAOgm (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 09:36:42 -0500
Received: from rgout0403.bt.lon5.cpcloud.co.uk ([65.20.0.216]:31077 "EHLO
        rgout04.bt.lon5.cpcloud.co.uk" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1031055AbeCAOgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 09:36:40 -0500
X-OWM-Source-IP: 86.134.53.209 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-RazorGate-Vade-Classification: clean
X-RazorGate-Vade-Verdict: clean 0
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-SNCR-VADESECURE: CLEAN
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedtfedrieejgdeijecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkffuhffvffgjfhgtofgggfesthejredtredtjeenucfhrhhomheptfhitghhrghrugcujfgrihhnvghsuceorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucfkphepkeeirddufeegrdehfedrvddtleenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeek
Message-ID: <1519914989.3063.1.camel@btinternet.com>
Subject: Re: Regression found when running LTP connect01 on next-20180301
From: Richard Haines <richard_c_haines@btinternet.com>
To: Paul Moore <paul@paul-moore.com>,
        Anders Roxell <anders.roxell@linaro.org>
Cc: netdev@vger.kernel.org, selinux@tycho.nsa.gov,
        linux-kernel@vger.kernel.org
Date: Thu, 01 Mar 2018 14:36:29 +0000
In-Reply-To: <CAHC9VhQAnsSTK4V2w3+CiikR6465Jpnu7_vr=3VFEQch7LECtA@mail.gmail.com>
References: <20180301083316.GA6779@localhost.localdomain>
         <CAHC9VhQAnsSTK4V2w3+CiikR6465Jpnu7_vr=3VFEQch7LECtA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.5 (3.26.5-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-03-01 at 08:42 -0500, Paul Moore wrote:
> On Thu, Mar 1, 2018 at 3:33 AM, Anders Roxell <anders.roxell@linaro.o
> rg> wrote:
> > Hi,
> > 
> > I was running LTP's testcase connect01 [1] and found a regression
> > in linux-next
> > (next-20180301).  Bisect gave me this patch as the problematic
> > patch (sha
> > d452930fd3b9 "selinux: Add SCTP support") on a x86 target.
> > 
> > Output from the test(LTP release 20180118):
> > $ cd /opt/ltp/
> > $ cat runtest/syscalls |grep connect01>runtest/connect-syscall
> > $ ./runltp -pq -f connect-syscall
> > "
> > Running tests.......
> > connect01    1  TPASS  :  bad file descriptor successful
> > connect01    2  TPASS  :  invalid socket buffer successful
> > connect01    3  TPASS  :  invalid salen successful
> > connect01    4  TPASS  :  invalid socket successful
> > connect01    5  TPASS  :  already connected successful
> > connect01    6  TPASS  :  connection refused successful
> > connect01    7  TFAIL  :  connect01.c:146: invalid address family ;
> > returned -1 (expected -1), errno 22 (expected 97)
> > INFO: ltp-pan reported some tests FAIL
> > LTP Version: 20180118
> > "
> > 
> > The output from the test expected 97 and we received 22, can you
> > please
> > elaborate on what have been changed?
> > 
> > Cheers,
> > Anders
> > [1] https://github.com/linux-test-project/ltp/blob/20180118/testcas
> > es/kernel/syscalls/connect/connect01.c#L146
> 
> Hi Anders,
> 
> Thanks for the report.  Out of curiosity, we're you running the full
> LTP test suite and this was the only failure, or did you just run the
> connect01 test?  Either answer is fine, I'm just trying to understand
> the scope of the regression.
> 
> Richard, are you able to look into this?  If not, let me know and
> I'll
> dig a bit deeper (I'll likely take a quick look today, but if the
> failure is subtle it might require some digging).

I'll have a look today.
> 
