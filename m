Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C55AC43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 12:46:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B68162736F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 12:46:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="Xyvij7l9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B68162736F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965833AbeF1MqR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 08:46:17 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:16260 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965788AbeF1MqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 08:46:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1530189976; x=1561725976;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version;
  bh=lAZUxsqXIZ0xthuyn7+s+gdQeDQg6xUlJvgnuc3bylI=;
  b=Xyvij7l9I0bdCwW0eB/SYo4XcyS1UZ8Ow1P/7CPRpOL63smv2DyVWPnZ
   JrTKF/MIu/xELHDtNonf6Q8OunOzDQr3LrxEnX+yH4F7/1PTQaHLKuePH
   uJ1t2n7MKwdCCzqpGampPjyckDNTfhUqFO+OO4aEMVMAObEPH0JuP8/62
   g=;
X-IronPort-AV: E=Sophos;i="5.51,283,1526342400"; 
   d="scan'208";a="620006077"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-2b-c7131dcf.us-west-2.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 28 Jun 2018 12:46:12 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-2b-c7131dcf.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id w5SCk8kN119957
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL)
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 12:46:11 GMT
Received: from EX13D02EUC001.ant.amazon.com (10.43.164.92) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 28 Jun 2018 12:46:11 +0000
Received: from EX13MTAUEE001.ant.amazon.com (10.43.62.200) by
 EX13D02EUC001.ant.amazon.com (10.43.164.92) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 28 Jun 2018 12:46:10 +0000
Received: from uc1a35a69ae4659.ant.amazon.com (10.28.85.80) by
 mail-relay.amazon.com (10.43.62.226) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Thu, 28 Jun 2018 12:46:09 +0000
From:   Norbert Manthey <nmanthey@amazon.de>
To:     Norbert Manthey <nmanthey@amazon.de>,
        <linux-kernel@vger.kernel.org>
Subject: less-CONFIG_NET v2
Date:   Thu, 28 Jun 2018 14:45:28 +0200
Message-ID: <1530189936-25780-1-git-send-email-nmanthey@amazon.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <ef0fe0ef-3620-3628-2a7e-c8b73e466a21@amazon.de>
References: <ef0fe0ef-3620-3628-2a7e-c8b73e466a21@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the first version of this series, I found a compilation error after
running make randconfig multiple times. I fixed the error, and rebased
the series. Furthermore, this series passed many make randconfig
compilations, as well as a compilation test for multiple architectures
and configurations.

Amazon Development Center Germany GmbH
Berlin - Dresden - Aachen
main office: Krausenstr. 38, 10117 Berlin
Geschaeftsfuehrer: Dr. Ralf Herbrich, Christian Schlaeger
Ust-ID: DE289237879
Eingetragen am Amtsgericht Charlottenburg HRB 149173 B

