Date: Thu, 22 Feb 2018 13:29:37 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org
Subject: [GIT PULL] Char/Misc driver fixes for 4.16-rc6
Message-ID: <20180222122937.GA30727@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.3 (2018-01-21)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The following changes since commit 7928b2cbe55b2a410a0f5c1f154610059c57b1b2:

  Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git/ tags/char-misc-4.16-rc3

for you to fetch changes up to 2a4ac172c2f257d28c47b90c9e381bec31edcc44:

  mei: me: add cannon point device ids for 4th device (2018-02-20 08:58:42 +0100)

----------------------------------------------------------------
Char/Misc driver fixes for 4.16-rc3

Here are a handful of char/misc driver fixes for 4.16-rc3.

There are some binder driver fixes to resolve reported issues in stress
testing the recent binder changes, some extcon driver fixes, and a few
mei driver fixes and new device ids.

All of these, with the exception of the mei driver id additions, have
been in linux-next for a while.  I forgot to push out the mei driver id
additions to kernel.org until today, but all build tests pass with them
enabled.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alexander Usyskin (1):
      mei: me: add cannon point device ids

Eric Biggers (1):
      binder: check for binder_thread allocation failure in binder_poll()

Greg Kroah-Hartman (1):
      Merge tag 'extcon-fixes-for-4.16-rc3' of git://git.kernel.org/.../chanwoo/extcon into char-misc-linus

Hans de Goede (3):
      extcon: axp288: Constify the axp288_pwr_up_down_info array
      Revert "extcon: axp288: Redo charger type detection a couple of seconds after probe()"
      extcon: int3496: process id-pin first so that we start with the right status

Martijn Coenen (1):
      ANDROID: binder: synchronize_rcu() when using POLLFREE.

Todd Kjos (2):
      ANDROID: binder: remove WARN() for redundant txn error
      binder: replace "%p" with "%pK"

Tomas Winkler (2):
      mei: set device client to the disconnected state upon suspend.
      mei: me: add cannon point device ids for 4th device

 drivers/android/binder.c              | 29 ++++++++++++++++++++++------
 drivers/extcon/extcon-axp288.c        | 36 ++++-------------------------------
 drivers/extcon/extcon-intel-int3496.c |  3 ++-
 drivers/misc/mei/bus.c                |  6 ------
 drivers/misc/mei/client.c             |  6 ++++++
 drivers/misc/mei/hw-me-regs.h         |  5 +++++
 drivers/misc/mei/pci-me.c             |  5 +++++
 7 files changed, 45 insertions(+), 45 deletions(-)
