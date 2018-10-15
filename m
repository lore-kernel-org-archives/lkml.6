Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37A62C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 16:19:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F26B42089E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 16:19:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F26B42089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=efficios.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726790AbeJPAF3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 20:05:29 -0400
Received: from mail-oi1-f176.google.com ([209.85.167.176]:39419 "EHLO
        mail-oi1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726708AbeJPAF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 20:05:29 -0400
Received: by mail-oi1-f176.google.com with SMTP id y81-v6so15528886oia.6
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 09:19:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=OBidlabW+0c5MShakJq6baRziGrktIX03N+pDF2e/qQ=;
        b=RQjfmNkv11ZjyfFK1PFwrw5/MGHave/uHDoWiFu7CdYL1E/+nBOXvbV0327U65T6NK
         2liSbDcMq+vyUEofDF5/pe/F5EkoDzHWYZc4D4rK1zvEk1iQ4YGKEzYoHKP1KqwxE+WP
         dGTLa/U9Gze/kPYGQv9A3/i/p9SQKFD5H3/TZuxyg/lzdNQQhSTsKHo3V4kCt8gesX95
         h5/q5k9xukDxnD4pJaPIv9pzmFuFPHXbr2qjyZAn/TfY5bWvILLPhPZ2gphWdbUOAyoG
         cPNslRjHQggLYeq+8jU3pt+7AIKPJfIpXdSmhRc95YCPh8pC+eMhRfhhywUiitG/eodu
         MFRg==
X-Gm-Message-State: ABuFfoh31QD+0uK1O3Bfq21LdZFSSxeqWs0Z1xTSRq3hsAMHRXOLdr9X
        czBeNw3xp33GBoZLrx+MmGdkHXHMk6YTEU8IWUYqsA==
X-Google-Smtp-Source: ACcGV60xIQhIYEX5zL4c7tnXWV+Nolv/HwvkO7d83OyfWWP7h3NUI4qjOGSUPyVewDeiWrNCN6LxXTUCpJTcEOH5M2s=
X-Received: by 2002:aca:d05c:: with SMTP id h89-v6mr9114417oig.199.1539620375241;
 Mon, 15 Oct 2018 09:19:35 -0700 (PDT)
MIME-Version: 1.0
From:   Francis Deslauriers <francis.deslauriers@efficios.com>
Date:   Mon, 15 Oct 2018 12:19:24 -0400
Message-ID: <CADcCL0gyN=vAPLAYX010NAoCyg_XCqzW2at7PtbZdrjSbfRChw@mail.gmail.com>
Subject: [BETA RELEASE] LTTng Scope 0.4
To:     lttng-dev <lttng-dev@lists.lttng.org>,
        diamon-discuss@lists.linuxfoundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

We are announcing the release of LTTng Scope 0.4.0.

This release has a few improvements over LTTng Scope 0.3:

* Open more than one trace thanks to the new "Trace Project Setup"
  window. (e.g. Kernel + UST traces)

  You can always reopen this window to add traces to or remove traces
  from the current trace project by clicking
  "File" -> "Project Setup..." or by right-clicking the project item in
  the left pane and clicking "Project Setup".

* Event count chart: use vertical bars instead of an area chart. A given
  bar indicates the number of event records of which the timestamps are
  between the beginning and the end of the bar.

* Event count chart: use natural ticks, depending on the current zoom
  level, on the horizontal (time) axis. For example, the difference
  between individual ticks can be 100 ms, 500 ms, 1 s, 2 s, 15 s, 30
  minutes, 1 day, etc.

* Event count chart: add axis units ("Count / Time") below the view's
  title on the left.

* Add the version to the main window's title bar.

* Bug fix: refresh the views when you move vertical dividers or when you
  resize the main window.

* Bug fix: event count chart: round tick labels correctly to avoid
  noticing floating point number errors.

Of course, because LTTng Scope's development is still in the beta phase,
you could discover bugs when trying the tool. Feel free to report them
on GitHub: <https://github.com/lttng/lttng-scope/issues>.

Project's description and screenshot:
    <https://lttng.org/beta/#lttng-scope>

GitHub page:
    <https://github.com/lttng/lttng-scope>

Installer for Linux:
    <https://lttng.org/files/lttng-scope/lttng-scope-0.4.0-linux-x64-installer.run>

Installer for Windows:
    <https://lttng.org/files/lttng-scope/lttng-scope-0.4.0-windows-installer.exe>

Installer for macOS:
    <https://lttng.org/files/lttng-scope/lttng-scope-0.4.0-osx-installer.dmg>

On the behalf of the EfficiOS team,

--
Francis Deslauriers
Software developer
EfficiOS inc.
