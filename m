Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1346284-1521811957-2-1135484187168208900
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521811955; b=GKxHc7Oh/f+ht0Q53bBnD7XPBljYn3nqxzCa7cBrBX2hbkQ
    IbHuWaL01v44vlBUg6MUmAc9o/el4jyAp5quyZnDA9rGP1+X2+J3z1ZEtcxyI0Wi
    sONs35/+dOMLG04/RjVWgI2pCmEumYE2rj8MTsTfsz1EeVDs1JLdcg3Bx4GPRfa1
    MfAOQEN/vqc07lYQc420t5wNFCVbiUDHFl2PIOLtiSVJT+pnXmsbLLOFfIGgISVD
    3nzHf04lI5o6BGoURivr7z5zTzxUP70FsHXL0SBC30CarGOkIRIDNYEaI+lP5OXX
    Y14+O4w61E7cWcSP94MUwBgNm/GY1rCdElDQJVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :mime-version:list-id:list-unsubscribe:list-archive:list-post
    :list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521811955; bh=u
    YnOJ5pvgZsIXJhF0Lck1G7uj8Ie53NyDyUiADtcJ4c=; b=LfROHALe1LekyPF3c
    1OmV3/hb03+d3Vf7U3DJtCxMyZRKRSUZhVKJaRUo5iTA1UmpbTSLzNi1f0F0AXMi
    aP2fLZDJmXTXG09tximK4w8KP7D6im/fhCCjomvaTFpUS4u38sm3bzPJ/KioMJEI
    Jg/feV/IbsVpiNFeXZsAAun/Z8oC1dt05XfCzFsuMZzyse3T1TEwPEUw+Tre2fiJ
    J3toDXzF54VoqDo2CX2TFrf9mtrRKWii4nsKX8uaLf3UzwZdMT2fRa4I9yzdFEZ7
    y+nf/h0/3iq2sUdFiV4E+2VSdYCzge9h8acK1cH33VXzcw/wQt0M9STUVxuK0oaW
    Afgjg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Fri, 23 Mar 2018 14:32:26 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [GIT PULL] Staging fixes for 4.16-rc7
Message-ID: <20180323133226.GA27295@kroah.com>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: devel@linuxdriverproject.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The following changes since commit c698ca5278934c0ae32297a8725ced2e27585d7f:

  Linux 4.16-rc6 (2018-03-18 17:48:42 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git/ tags/staging-4.16-rc7

for you to fetch changes up to 4c41aa24baa4ed338241d05494f2c595c885af8f:

  staging: ncpfs: memory corruption in ncp_read_kernel() (2018-03-19 16:31:39 +0100)

----------------------------------------------------------------
Staging/IIO fixes for 4.16-rc7

Here are a few small Staging and IIO fixes for various reported issues.

All of them are tiny, the majority being iio driver fixes for small
issues, and one staging driver fix for a memory corruption issue.

All have been in linux-next with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Dan Carpenter (2):
      iio: adc: meson-saradc: unlock on error in meson_sar_adc_lock()
      staging: ncpfs: memory corruption in ncp_read_kernel()

Fabrice Gasnier (5):
      iio: adc: stm32-dfsdm: fix compatible data use
      iio: adc: stm32-dfsdm: fix call to stop channel
      iio: adc: stm32-dfsdm: fix clock source selection
      iio: adc: stm32-dfsdm: fix multiple channel initialization
      dt-bindings: iio: adc: sd-modulator: fix io-channel-cells

Greg Kroah-Hartman (1):
      Merge tag 'iio-fixes-for-4.16b' of git://git.kernel.org/.../jic23/iio into staging-linus

Jonathan Cameron (1):
      Revert "iio: accel: st_accel: remove redundant pointer pdata"

Michael Nosthoff (1):
      iio: st_pressure: st_accel: pass correct platform data to init

Richard Lai (1):
      iio: chemical: ccs811: Corrected firmware boot/application mode transition

 .../bindings/iio/adc/sigma-delta-modulator.txt     |  4 +--
 drivers/iio/accel/st_accel_core.c                  |  7 +++-
 drivers/iio/adc/meson_saradc.c                     |  4 ++-
 drivers/iio/adc/stm32-dfsdm-adc.c                  | 39 ++++++++++++----------
 drivers/iio/adc/stm32-dfsdm-core.c                 | 12 +++++--
 drivers/iio/chemical/ccs811.c                      |  3 ++
 drivers/iio/pressure/st_pressure_core.c            |  2 +-
 drivers/staging/ncpfs/ncplib_kernel.c              |  4 +++
 8 files changed, 50 insertions(+), 25 deletions(-)
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
