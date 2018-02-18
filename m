Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751603AbeBRToi (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Feb 2018 14:44:38 -0500
Received: from asavdk3.altibox.net ([109.247.116.14]:44624 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751383AbeBRToh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Feb 2018 14:44:37 -0500
Date: Sun, 18 Feb 2018 20:44:33 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-kbuild@vger.kernel.org, Michal Marek <michal.lkml@markovi.net>,
        Ulf Magnusson <ulfalizer@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>, linux-kernel@vger.kernel.org,
        Marc Herbert <marc.herbert@intel.com>
Subject: Re: [PATCH 1/2] kconfig: remove check_stdin()
Message-ID: <20180218194433.GB29324@ravnborg.org>
References: <1518069400-7037-1-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1518069400-7037-1-git-send-email-yamada.masahiro@socionext.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=W9cWqyek c=1 sm=1 tr=0
        a=ddpE2eP9Sid01c7MzoqXPA==:117 a=ddpE2eP9Sid01c7MzoqXPA==:17
        a=kj9zAlcOel0A:10 a=6apBCMZNcEVXj91zlXAA:9 a=CjuIK1q_8ugA:10
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 08, 2018 at 02:56:39PM +0900, Masahiro Yamada wrote:
> Except silentoldconfig, valid_stdin is 1, so check_stdin() is no-op.
> 
> oldconfig and silentoldconfig work almost in the same way except that
> the latter generates additional files.  Both ask users for input for
> new symbols.
> 
> I do not know why only silentoldconfig requires stdio be tty.

The general idea was to error out if stdout was not a tty and
kconfig wanted to prompt the user for anything.

So we avoided having a kconfig that would hang waiting for
user inputs when the user could not see that anything was prompted for.

The actual implementation may not follow this today as many seems not
to be aware of this little trick.

	Sam
