Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0ECDC46462
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 20:15:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3619208A2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 20:15:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3619208A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732585AbeGaV5P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 17:57:15 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58934 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726582AbeGaV5O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 17:57:14 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 62BE74001389;
        Tue, 31 Jul 2018 20:15:12 +0000 (UTC)
Received: from madcap2.tricolour.ca (ovpn-112-17.rdu2.redhat.com [10.10.112.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DFC9C215670D;
        Tue, 31 Jul 2018 20:15:10 +0000 (UTC)
From:   Richard Guy Briggs <rgb@redhat.com>
To:     containers@lists.linux-foundation.org,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     eparis@parisplace.org, Steve Grubb <sgrubb@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        Richard Guy Briggs <rgb@redhat.com>
Subject: [PATCH ghau51/ghau40 v4 0/6] add support for audit container identifier
Date:   Tue, 31 Jul 2018 16:11:35 -0400
Message-Id: <1533067901-21817-1-git-send-email-rgb@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Tue, 31 Jul 2018 20:15:12 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Tue, 31 Jul 2018 20:15:12 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'rgb@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for audit kernel container identifiers to userspace tools.

The first and second add new record types.  The third adds filter
support.  The fourth and 5th start to add search support.

The last is intended for debugging and not for upstream, matching the
kernel /proc read patch.

See: https://github.com/linux-audit/audit-userspace/issues/51
See: https://github.com/linux-audit/audit-userspace/issues/40
See: https://github.com/linux-audit/audit-kernel/issues/90
See: https://github.com/linux-audit/audit-kernel/issues/91
See: https://github.com/linux-audit/audit-testsuite/issues/64
See: https://github.com/linux-audit/audit-kernel/wiki/RFE-Audit-Container-ID

Richard Guy Briggs (6):
  AUDIT_CONTAINER_OP message type basic support
  AUDIT_CONTAINER message type basic support
  auditctl: add support for AUDIT_CONTID filter
  add ausearch containerid support
  start normalization containerid support
  libaudit: add support to get the task audit container identifier

 auparse/normalize_record_map.h |   1 +
 docs/Makefile.am               |   2 +-
 docs/audit_get_containerid.3   |  25 ++++++
 docs/auditctl.8                |   3 +
 lib/fieldtab.h                 |   1 +
 lib/libaudit.c                 |  65 ++++++++++++++
 lib/libaudit.h                 |  16 ++++
 lib/msg_typetab.h              |   2 +
 lib/netlink.c                  |   1 +
 src/auditctl-listing.c         |  21 +++++
 src/aureport-options.c         |   1 +
 src/ausearch-llist.c           |   2 +
 src/ausearch-llist.h           |   1 +
 src/ausearch-match.c           |   3 +
 src/ausearch-options.c         |  47 +++++++++-
 src/ausearch-options.h         |   1 +
 src/ausearch-parse.c           | 199 +++++++++++++++++++++++++++++++++++++++++
 17 files changed, 389 insertions(+), 2 deletions(-)
 create mode 100644 docs/audit_get_containerid.3

-- 
1.8.3.1

