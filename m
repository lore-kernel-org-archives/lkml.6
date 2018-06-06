Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id lJ/2A+tDGFsWXwAAmS7hNA
	; Wed, 06 Jun 2018 20:28:27 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id F01FA607F7; Wed,  6 Jun 2018 20:28:26 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 25B5260290;
	Wed,  6 Jun 2018 20:28:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 25B5260290
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=juzza.co.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932330AbeFFU2Y (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 16:28:24 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:47287 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752259AbeFFU2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 16:28:22 -0400
Received: from tanglefoot ([86.19.254.212]) by mrelayeu.kundenserver.de
 (mreue105 [212.227.15.179]) with ESMTPSA (Nemesis) id
 0Lmc9z-1g0ojr3G9j-00aCXb; Wed, 06 Jun 2018 22:28:16 +0200
Date: Wed, 6 Jun 2018 21:28:12 +0100
From: Justin Skists <justin.skists@juzza.co.uk>
To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
        "Speakup is a screen review system for Linux."
        <speakup@linux-speakup.org>, devel@driverdev.osuosl.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: speakup: refactor synths array to use a list
Message-ID: <20180606202812.GA25689@tanglefoot>
References: <20180604095212.GA18381@tanglefoot>
 <20180606132628.fxykchbznrwzgwqt@var.youpi.perso.aquilenet.fr>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="17pEHd4RhPHOinZp"
Content-Disposition: inline
In-Reply-To: <20180606132628.fxykchbznrwzgwqt@var.youpi.perso.aquilenet.fr>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Provags-ID: V03:K1:kFFnz8crkv9ZiygJ44AQodX4rtl/eD8eiH1UbXe7zORLfOfP/4W
 S5SkY5rEUQbLlPZlKfOWWfrkYfYGK9K3xUneBXUaxrmHSYsENvexx5B7U3QLWtZ1+Fklvwm
 iquQD5Dqdc2lF5UTgviNZeFK8Ogbz/pbf0orcXCJJhXpZUEc+9k9+bNrFpoE05KjB/OqDT2
 dxZGD2nvbKrv/XG1ilNGA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:zynH3o3dV9g=:N8gVUvpxvXXcOmwTdpeP1C
 PXolglRKLC1ObF+Jd5HmiBcILb1o3g6axdc6hVsOF61ayLbU+QztjTEFqiqhxUC3Ihe8t4DFf
 h8LH+XJJ2hZ/ki/3B5QDPm74K8xqV8avf1vmMkR1XC8z9dwdc842emPp2P14HGw+u6L/V2pu3
 /5fvbDZnKjaIiFp4S0xmtBYw5f6b7TIBdzptZerbYjEdDY5eeOMmTfrozywOePLWurPWUeSci
 a1Qplowyr5jHlPwxPagagRH/w7WbRiphkoeNRHGE4XQTzwMewVs0B61APGFk+n1G2MZr9+px9
 8ildmHZSuxe7NeTVJk9m7+ZIYQVmVIUzphAJJFBtosQNkqPJFfp71ZtPeBWdkD/waWrIHokoC
 uIzTnfySowsTzk/O8EiPhpE7Ya1jvrBU57UCxoXJMFcPR36RW5fKxHzrObFDFw0wxjhY1/kR+
 ROn9blpgtdcFueiih1PcMkaPTi8Kkbvph2MQBstSkWM/AY33sQhzAhEYlYx2xFYr91JNsOiL1
 U+d64vq+xG1zMA0UdYyuwnninlrh9hxg3lbczKXsMxAkPis/ZulY/5pt/bFvVbYtV05zroUaw
 ALFTTaFRv2yzOVpiE9wzAyACl25Qb1XNC2ZoNWQsi0yAuC66Xg9KRkdRe7TQvErmmABz9Ebvj
 k+fRwUUUtWesX2oSUb/xm/83iLbNw0mYijzulw061NTxosVbs/Z58VcK2PYGUnLhoUnE=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--17pEHd4RhPHOinZp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 06, 2018 at 03:26:28PM +0200, Samuel Thibault wrote:
> Hello,
> 
> Justin Skists, le lun. 04 juin 2018 10:52:12 +0100, a ecrit:
> > The synths[] array is a collection of synths acting like a list.
> > There is no need for synths to be an array, so refactor synths[] to use
> > standard kernel list_head API, instead, and modify the usages to suit.
> > As a side-effect, the maximum number of synths has also become redundant.
> 
> This looks good to me,
> 
> Reviewed-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

Thank you.


> Did you test to e.g. insmod speakup_soft ; insmod speakup_dummy ; rmmod
> speakup_soft ; rmmod speakup_dummy
> 
> to make sure it did work correctly?

I did. And I swapped synths via the sysfs interface.

As always, it's always good to double-check. So, I've scripted the test
sequence that I used and attached the output.

> I'd also rather see it tested in the real wild before committing.

As it should be. :)

Justin

--17pEHd4RhPHOinZp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="evidence.txt"


Kernel info
-----------
# uname -a
Linux buildroot 4.17.0-rc7-next-20180601 #1 SMP Mon Jun 4 09:31:05 BST 2018 x86_64 GNU/Linux

insert modules
--------------
# modprobe speakup
# modprobe speakup_dummy dev=ttyS1 ser=1 start=1
# modprobe speakup_soft
# lsmod
Module                  Size  Used by    Tainted: G  
speakup_soft           16384  0 
speakup_dummy          16384  0 
speakup               118784  2 speakup_soft,speakup_dummy

switching to soft
-----------------
# echo 'soft' > /sys/accessibility/speakup/synth
# cat /sys/accessibility/speakup/synth
soft

switching to dummy
------------------
# echo 'dummy' > /sys/accessibility/speakup/synth
# cat /sys/accessibility/speakup/synth
dummy

Removing modules
----------------
# rmmod speakup_dummy
# rmmod speakup_soft
# lsmod
Module                  Size  Used by    Tainted: G  
speakup               118784  0 

view message log
----------------
# tail -25 /var/log/messages
Jun  6 20:06:57 buildroot kern.notice kernel: random: ssh-keygen: uninitialized urandom read (32 bytes read)
Jun  6 20:06:57 buildroot kern.notice kernel: random: sshd: uninitialized urandom read (32 bytes read)
Jun  6 20:06:57 buildroot auth.info sshd[105]: Server listening on :: port 22.
Jun  6 20:06:57 buildroot auth.info sshd[105]: Server listening on 0.0.0.0 port 22.
Jun  6 20:06:57 buildroot daemon.info : starting pid 107, tty '/dev/tty1': '/sbin/getty -L  tty1 0 vt100 '
Jun  6 20:07:00 buildroot auth.info login[107]: root login on 'tty1'
Jun  6 20:07:08 buildroot kern.notice kernel: random: crng init done
Jun  6 20:07:12 buildroot kern.warn kernel: speakup: module is from the staging directory, the quality is unknown, you have been warned.
Jun  6 20:07:13 buildroot kern.info kernel: input: Speakup as /devices/virtual/input/input4
Jun  6 20:07:13 buildroot kern.info kernel: initialized device: /dev/synth, node (MAJOR 10, MINOR 25)
Jun  6 20:07:13 buildroot kern.info kernel: speakup 3.1.6: initialized
Jun  6 20:07:13 buildroot kern.info kernel: synth name on entry is: (null)
Jun  6 20:07:13 buildroot kern.warn kernel: speakup_dummy: module is from the staging directory, the quality is unknown, you have been warned.
Jun  6 20:07:13 buildroot kern.warn kernel: synth probe
Jun  6 20:07:13 buildroot kern.warn kernel: speakup_soft: module is from the staging directory, the quality is unknown, you have been warned.
Jun  6 20:07:13 buildroot kern.info kernel: releasing synth dummy
Jun  6 20:07:13 buildroot kern.warn kernel: synth probe
Jun  6 20:07:13 buildroot kern.info kernel: initialized device: /dev/softsynth, node (MAJOR 10, MINOR 26)
Jun  6 20:07:13 buildroot kern.info kernel: initialized device: /dev/softsynthu, node (MAJOR 10, MINOR 27)
Jun  6 20:07:13 buildroot kern.warn kernel: soft already in use
Jun  6 20:07:13 buildroot kern.info kernel: releasing synth soft
Jun  6 20:07:13 buildroot kern.info kernel: unregistered /dev/softsynth
Jun  6 20:07:13 buildroot kern.info kernel: unregistered /dev/softsynthu
Jun  6 20:07:13 buildroot kern.warn kernel: synth probe
Jun  6 20:07:13 buildroot kern.info kernel: releasing synth dummy

--17pEHd4RhPHOinZp--
