Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1148932-1519337443-2-581709810260894492
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519337442; b=EI3NiOiJDrQPTtRtwC0YUiruI7CYOZHiAZavq1BrntDBOhw
    RvXn9tK3SK1rRbW95MJqxhuEZgWtBJOeamOWgbYuGQM3DgA9eZusBHfhdzyVeW6B
    oqe8/joRfGgIaLICWfBBlqnY3x2+hOZmfDob8fw/D1iccM7OUZPWjQbn4Na8/O7o
    r9MCsBn2ELa6nQN8zOmigLToty3gkmWRfPozdVkVi9ZEQG9VMH4gJb16FKYv+eJK
    ZPZo505GzeI5BbfWa+NEmhfwDUvPCx+z2fh8aIkPBTCK052djLuY6ibxrVGKoSKD
    0mye54U8QdvyTCWBR1ZYTwxHdQVNFNeh6h5pcJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:date:subject:message-id
    :mime-version:list-id:list-unsubscribe:list-archive:list-post
    :list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1519337442; bh=9
    02GTlM/YfQ8HAHjofrc77xB3lHApWnfkI5g8hGLQJQ=; b=QLW60ZWVWCbtbDd5I
    RebSJFNM8SQ7IwiXeTszRAo3Ng24Pk5Tkj1TYnuUoxhg+wpoyiXn1YJaJZViBfoj
    eP/1XYUhmE9UvSbiy3OMyXUeJFaht0oFTpKud/5YF0ssuM+tu4N5fDDp4CPi8Dg3
    SHArV87bDvCz4yEdz3y1jZJpuhtFPXFBc74JJDESE63rk1O94SY0flQ07Vn8J/cK
    fODFDgaslfmektI2FF8eZtJJ8QGHjjp0tvjiiAEAEtS1jNNyOlLdeoZLRHIuxDpF
    bFDrK8MeLZNjlyzSAWA8J19XbIyMTOwGw55j/AemVrN8TCkBAZHr678t32JGPpWt
    tWqcA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=suse.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=suse.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: NeilBrown <neilb@suse.com>
To: devel@driverdev.osuosl.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Oleg Drokin <oleg.drokin@intel.com>, James Simmons <jsimmons@infradead.org>,
 Andreas Dilger <andreas.dilger@intel.com>
Date: Fri, 23 Feb 2018 09:09:33 +1100
Subject: [PATCH 0/3] Three lustre bugfixes
Message-ID: <151933726925.16436.9827896439357574011.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
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
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Lustre Development List <lustre-devel@lists.lustre.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

First two patches fix bugs that have been prevented the test suite
from finished for me - now it completes with about 10% of tests
failing.

Third patch fixes a tiny bug I noticed while reviewing another recent
patch to the same file.

Thanks,
NeilBrown

---

NeilBrown (3):
      staging: lustre: lov: use correct env in lov_io_data_version_end()
      staging: lustre: lmv: correctly iput lmo_root
      staging: lustre: lnet/selftest: don't ignore status from lstcon_test_add


 drivers/staging/lustre/lnet/selftest/conctl.c |    2 +-
 drivers/staging/lustre/lustre/lmv/lmv_obd.c   |    2 +-
 drivers/staging/lustre/lustre/lov/lov_io.c    |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

--
Signature

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
