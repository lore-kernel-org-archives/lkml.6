Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3238303-1520553364-2-16891577864313521288
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520553364; b=YXOxpj9RhwFoXNQ56J2RlBdhQYJPixVGVN39jd6QdPmoAIe
    JacChziCrxg5ctCB+ddq3m07Fzm/aoC+6/+cpvFWMFRrfH3BE9+W40ztwMGTXN5L
    Aftp9Z1xc1X58BZspmlUpSYTMwMqxMia+glXQiJDg/L9uGu6AcDDBTkF9UN5LqxW
    998o7EbX+uwtbHvZeMWw0t1f/kUR8ExFBS/xV6YdsIVEUJi02kZC4S2MYuAsmeaa
    PBgwAdlKHBkfuYsrNyZU3PAXjTFdap9ZYbMG5kMpZ2xDPZQxM1X/iY7PmZ/tA07R
    DT6ky3/W9ZZ/SnpvB29i/1QtFgC2B1y1L76tQcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :mime-version:content-type:sender:list-id; s=arctest; t=
    1520553364; bh=nHkmOYddrF0HdwbIMXBVKyTgDxcFg6WA1szop47v1Sg=; b=o
    yjrQ52Lb9U6PqhO8nJ+m+2VEmXvI/ILn5TmTvIbywksvF8Bcci8Y8xCWiHuIsvLo
    4gJLc540ZSfFhsHTK3tUR7SDIEOlnQcyIzcI1xY40j2n9fD5TYo+a3ooSlNJVQtq
    jHd2ZV5GRWqIpvNFFKFqfvxSaobLR1Y7ksQwSzh1GK31Zsu1wef5iBqhmDXsSLdg
    200OeuBCb6zgmlT5JHZTHu7SUKMqbeW23b+TqTdkKKN3hve1AyspGlbJsdQezN87
    eSBCJldzQK032GvNQ0B0HrlsujFMAjrdrkIB9OpFJ5ex9Dk7PwpXQXzduFeOVsrt
    t0IhvaigEsKlQ+ipRSrnw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750859AbeCHX4C (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 18:56:02 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33410 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750824AbeCHX4C (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 18:56:02 -0500
Date: Fri, 9 Mar 2018 01:55:55 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, luto@kernel.org, mst@redhat.com,
        tiwei.bie@intel.com
Subject: [PULL resend] virtio: bugfix
Message-ID: <20180308012901-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Looks like my pull had corrupted headers. Resending with
fixed up ones.

The following changes since commit 4a3928c6f8a53fa1aed28ccba227742486e8ddcb:

  Linux 4.16-rc3 (2018-02-25 18:50:41 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to e82df670235138575b37ff0ec24412a471efd97f:

  virtio_ring: fix num_free handling in error case (2018-03-01 18:53:38 +0200)

----------------------------------------------------------------
virtio: bugfix

This includes a bugfix for error handling in virtio.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Tiwei Bie (1):
      virtio_ring: fix num_free handling in error case

 drivers/virtio/virtio_ring.c | 2 --
 1 file changed, 2 deletions(-)
