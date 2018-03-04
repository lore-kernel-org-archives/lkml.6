Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2841113-1520173041-2-3424890785827310342
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520173040; b=k9ksudSzrxu5dY/83/ZMPxpcRmRrtd3X+YEQO4H/np+dSg5
    BVuM2RShDshQwfM0wmXj9euMAZrRf+VsKC4FjShUXcGjXnlLx1Q9dI+uziMMqw0X
    sb1rJdi+bcoZ3RcNU14t478FHOM837E6Qx9mvKzdw+HXx+VkbidpG0VmDZWxdQCw
    RZuprcFqqmhHtYacKLkU6Cln4D+0omraaGCBFnb0PCOcMJzVd69vhIFsEH0jaJsm
    RQWmfZi4ysq6+st/9ArVG+2GYf+sx93EUT5V0JFvifHiOaPXrn4DK3GfKtwXRGf+
    dVDmeM4iLBlOoOAwYMnIEu1vYquP8q8kQTAc+Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520173040; bh=3
    aOTSiJdZHAPkwCvkkUrx/SIZOGEDj9jroKgssZ09tk=; b=KfGkYLSn5LhSjwpyS
    EJMDCT315uJHhjHjZJwU8vQnzzz/099Y6Lnnnc4LU+dbXck/bUDN+7T+lzfERfqa
    njyFq2CDYUhrtzwfZa1bB8j7oEf/hAJXrUvH2P42JF4j2xbCKeTZ04RS+wKG4jqM
    jePiKq8cGsn/geLBvezuDe8Cxpez0Jbxzn/Hl2EAVvXqVBA/OBHmKO+VHihYb/zR
    JlXLGsL6wCMhAVPGRFpPeI7GuoQ8F+vfKZMHnQq4lE2pL8W81OM/J7WiOBZdYkC3
    sFubCHtbNNTCfXXd5nKvVW7ugXb0ZkEFv68wKXy2eV+sgNCG4m5xEL5OLe2QsfQx
    FcS5w==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=BN9r3qvc x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Gxn/fsuM;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=BN9r3qvc x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Gxn/fsuM;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELtr3yDkpu5wkwq+UQwVg9TsKD1bl/76pH+TpnWHAip/8gRuqwlDPP+sCJFu4yR5Nz1DzrUg0w==
From: Arushi Singhal <arushisinghal19971997@gmail.com>
To: oleg.drokin@intel.com
Subject: [PATCH 0/3] staging: lustre: cleanup
Date: Sun,  4 Mar 2018 19:46:05 +0530
Message-Id: <1520172968-17448-1-git-send-email-arushisinghal19971997@gmail.com>
X-Mailer: git-send-email 2.7.4
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
Cc: devel@driverdev.osuosl.org,
 Arushi Singhal <arushisinghal19971997@gmail.com>, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com,
 andreas.dilger@intel.com, lustre-devel@lists.lustre.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Spellcheck the comments. 
Remove the repeated, consecutive words with single word.

Arushi Singhal (3):
  staging: lustre: Replace "be be" with "be"
  staging: lustre: Replace "to to" with "to"
  staging: lustre: Replace "dont" with "don't"

 drivers/staging/lustre/lnet/libcfs/debug.c             | 2 +-
 drivers/staging/lustre/lustre/fld/fld_cache.c          | 2 +-
 drivers/staging/lustre/lustre/include/cl_object.h      | 2 +-
 drivers/staging/lustre/lustre/include/lprocfs_status.h | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

-- 
2.7.4

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
