Date: Thu, 22 Feb 2018 13:29:59 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-kernel@vger.kernel.org, devel@linuxdriverproject.org
Subject: [GIT PULL] Staging/IIO fixes for 4.16-rc3
Message-ID: <20180222122959.GA30818@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.3 (2018-01-21)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The following changes since commit 7928b2cbe55b2a410a0f5c1f154610059c57b1b2:

  Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git/ tags/staging-4.16-rc2

for you to fetch changes up to c6754712e05317923e3f67ac01d45c7d5ec6f79f:

  Merge tag 'iio-fixes-for-4.16a' of git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into staging-linus (2018-02-20 10:03:22 +0100)

----------------------------------------------------------------
Staging/IIO fixes for 4.16-rc2

Here are a small number of staging and iio driver fixes for 4.16-rc2.

The IIO fixes are all for reported things, and the android driver fixes
also resolve some reported problems.  The remaining fsl-mc Kconfig
change resolves a build testing error that Arnd reported.

All of these have been in linux-next with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alexandru Ardelean (2):
      staging: iio: adc: ad7192: fix external frequency setting
      staging: iio: ad5933: switch buffer mode to software

Andreas Klinger (1):
      iio: srf08: fix link error "devm_iio_triggered_buffer_setup" undefined

Arnd Bergmann (1):
      staging: fsl-mc: fix build testing on x86

Ben Hutchings (1):
      staging: android: ashmem: Fix a race condition in pin ioctls

Christophe JAILLET (1):
      iio: adc: aspeed: Fix error handling path

Fabrice Gasnier (1):
      iio: adc: stm32: fix stm32h7_adc_enable error handling

Greg Kroah-Hartman (1):
      Merge tag 'iio-fixes-for-4.16a' of git://git.kernel.org/.../jic23/iio into staging-linus

Lars-Peter Clausen (1):
      iio: adis_lib: Initialize trigger before requesting interrupt

Liam Mark (1):
      staging: android: ion: Zero CMA allocated memory

Stefan Windfeldt-Prytz (1):
      iio: buffer: check if a buffer has been set up when poll is called

 drivers/iio/adc/aspeed_adc.c                    |  7 ++++---
 drivers/iio/adc/stm32-adc.c                     |  7 ++++---
 drivers/iio/imu/adis_trigger.c                  |  7 ++++---
 drivers/iio/industrialio-buffer.c               |  2 +-
 drivers/iio/proximity/Kconfig                   |  2 ++
 drivers/staging/android/ashmem.c                | 19 +++++++++--------
 drivers/staging/android/ion/ion_cma_heap.c      | 17 ++++++++++++++++
 drivers/staging/fsl-mc/bus/Kconfig              |  2 +-
 drivers/staging/iio/adc/ad7192.c                | 27 +++++++++++++++++--------
 drivers/staging/iio/impedance-analyzer/ad5933.c |  4 +---
 10 files changed, 64 insertions(+), 30 deletions(-)
