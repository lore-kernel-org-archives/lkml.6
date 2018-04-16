Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2210789-1523851820-2-6714487304017122990
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523851820; b=OfRKmBqywtFUkaV8JsxTDDhU4q2g3x16Rjl5s2LJZoNoWON15/
    tUJUu8rerZ/1Z95BHVqD7hX4aT2YIzQSJOd1aA8Tph78ss7swEmdIDjbcd880d+f
    FXht+8PBrwsq1+skEvA7tqqYuufsx1fV/g3RhwCKXYDdUoiQUipL1B7GcAThakBh
    q6oSsOMwPOYQLd1tM6xo2ReoENZmRJSVQjygGucab6Shb9aZAWn3Tk3fh0aJOD2a
    /WQqqDsDp0ov7WfQQBb1UjAIkOudbIjZe9iy318g+wg4jSl8pyMxOSJtH+BbQd3t
    4dB6lig53VHFbD6M2wn1PEZjwQABwhBdmVJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1523851820; bh=keiXm
    JEAdGuCuKX7sip29Q+gpRD+zxGT7I1sRomJkn8=; b=lPbJjAq734Z0WvR3DEbuE
    c3DU19oEtjQqSfwxg3CF9NEof9VfNOO5tjLDyxixgdwd6CGncBb5lVMDagzwK1Js
    UhE8VxMWmG5thP4mi4pS6CrGhsEG5jaVJ9VnSZNnxtDh5Zsh88QBSicv0ADq2DmU
    CPSkQ1JCJ8bjzjtgJR31I4fC1Too4yKa8xMLrGO3hVZEOnWRojkuonV/0T+D/8hU
    bpNFqKh795wTIuUXN6Ez5spUB3DsYd3omSBUAAUiRnvimBPe1CKUBb1PR6WAsDkM
    YLybLBIRDSKUI5jjy3qZwDonpQ9dCj9XYdHi452lA/zKXMfB5cglwwl4RwLqtmgy
    g==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=infradead.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=infradead.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNJWqq57XX05YkfXv5pkg/B/sfUwY9KfMQXqhM6WBT6KZcRVYIHsIVWypOJD5MHF2888zzk2YXVisR6oU2KI5Btn/P9c33ilZmThRR3lc1Kg/4QsWj3n
    Dj6AwlBvrjI1UpqAbczQW/zFdWLjsprryy3f3vMzIf1MXh3rqsG5K9SQoAC0dnt0llq0S8v/dth5IGs7nYBczoWv712QFv70TgyX/Y8It4nWI5cGrqCGxTBo
    UeeObelHs2K+vExs6Tr46Q==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=DDOyTI_5AAAA:8 a=RQeF5LcUpVqnTIu5x5MA:9
    a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: James Simmons <jsimmons@infradead.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 devel@driverdev.osuosl.org, Andreas Dilger <andreas.dilger@intel.com>,
 Oleg Drokin <oleg.drokin@intel.com>, NeilBrown <neilb@suse.com>
Subject: [PATCH 00/25] staging: lustre: libcfs: SMP rework
Date: Mon, 16 Apr 2018 00:09:42 -0400
Message-Id: <1523851807-16573-1-git-send-email-jsimmons@infradead.org>
X-Mailer: git-send-email 1.8.3.1
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Recently lustre support has been expanded to extreme machines with as
many as a 1000+ cores. On the other end lustre also has been ported
to platforms like ARM and KNL which have uniquie NUMA and core setup.
For example some devices exist that have NUMA nodes with no cores.
With these new platforms the limitations of the Lustre's SMP code
came to light so a lot of work was needed. This resulted in this
patch set which has been tested on these platforms.

Amir Shehata (9):
  staging: lustre: libcfs: implement cfs_cpt_cpumask for UMP case
  staging: lustre: libcfs: replace MAX_NUMNODES with nr_node_ids
  staging: lustre: libcfs: remove excess space
  staging: lustre: libcfs: replace num_possible_cpus() with nr_cpu_ids
  staging: lustre: libcfs: NUMA support
  staging: lustre: libcfs: add cpu distance handling
  staging: lustre: libcfs: use distance in cpu and node handling
  staging: lustre: libcfs: provide debugfs files for distance handling
  staging: lustre: libcfs: invert error handling for cfs_cpt_table_print

Dmitry Eremin (15):
  staging: lustre: libcfs: remove useless CPU partition code
  staging: lustre: libcfs: rename variable i to cpu
  staging: lustre: libcfs: fix libcfs_cpu coding style
  staging: lustre: libcfs: use int type for CPT identification.
  staging: lustre: libcfs: rename i to node for cfs_cpt_set_nodemask
  staging: lustre: libcfs: rename i to cpu for cfs_cpt_bind
  staging: lustre: libcfs: rename cpumask_var_t variables to *_mask
  staging: lustre: libcfs: rename goto label in cfs_cpt_table_print
  staging: lustre: libcfs: clear up failure patch in cfs_cpt_*_print
  staging: lustre: libcfs: update debug messages
  staging: lustre: libcfs: make tolerant to offline CPUs and empty NUMA nodes
  staging: lustre: libcfs: report NUMA node instead of just node
  staging: lustre: libcfs: update debug messages in CPT creation code
  staging: lustre: libcfs: rework CPU pattern parsing code
  staging: lustre: libcfs: change CPT estimate algorithm

James Simmons (1):
  staging: lustre: libcfs: merge UMP and SMP libcfs cpu header code

 .../lustre/include/linux/libcfs/libcfs_cpu.h       | 135 +--
 .../lustre/include/linux/libcfs/linux/libcfs.h     |   1 -
 .../lustre/include/linux/libcfs/linux/linux-cpu.h  |  78 --
 drivers/staging/lustre/lnet/libcfs/libcfs_cpu.c    | 126 ++-
 .../staging/lustre/lnet/libcfs/linux/linux-cpu.c   | 912 +++++++++++----------
 drivers/staging/lustre/lnet/libcfs/module.c        |  53 ++
 drivers/staging/lustre/lnet/lnet/lib-msg.c         |   2 +
 7 files changed, 676 insertions(+), 631 deletions(-)
 delete mode 100644 drivers/staging/lustre/include/linux/libcfs/linux/linux-cpu.h

-- 
1.8.3.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
