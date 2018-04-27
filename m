Return-Path: <sdias@qualcomm.com>
X-Google-Smtp-Source: AB8JxZpqNe0GmMAcT/5/iBRSsWRPAyN4/gA7EJNCPUBBbYBmZ80vThaGqnf0nJIwuQ8ExmMkicnn
ARC-Seal: i=1; a=rsa-sha256; t=1524795824; cv=none;
        d=google.com; s=arc-20160816;
        b=aKoMQcZtEY5M3+t6bXrBucy1UQ854LZq3aiWtTPJv5wpa7ywi/Ky17GJEk03Ksuhmt
         PBdKNanQVttddSKKR3nphNqo2J5g3WWvo35TPNhr9c7S7jn6cWREJ7jEJX8u+o++ksY6
         HOONaijCKR3pI4WNUzhk6v90QLhWqovdMP7bDnLoRqK+8GV3ZOmEmUYyHvUmraeZt9HD
         F18JDYtn8dQa36N5iZVe8Qgi/OnaOt20RTYm2gMudiAl7ToGkvhz64tOc3uv1yUp+pj6
         S/yer30cynXurfqIMOY+G963zZAPyqs1MCi/00i5WSXvbAxbEPW+RXCFKcUd/fTcB7Av
         keqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:arc-authentication-results;
        bh=FWyWCj008lRDGnSti29b6EB/gS4sP/rgUuZ6TcxBB3g=;
        b=bRs+mA2U4nlG3PGvRzdFRv/RWMCuHtZdpa7ItCW3FPNF0Bfnm/PRS79yndr350gKXF
         TWBvcjgmcy/5oDmbsl+HKBY8PBi782pc4BA0XT+q5qIN5Ezddq1+p2oZ4R8N2iAZmP3j
         JFATP5RkLgXUTAQa9YYLrtawwDHCx564bISRJaTURgfuQobMJTMKatq4hLwdeQ3Rjb/J
         fGmSpTUXlqSLvjaJhPlGVT5EiFH6zp4w5Sd9Lf6RPGmPnAa5iV1gRVRqGuPVXHChXo3P
         UBRbFSEohEgMl/UPkQkWWNIwB1z0eRx7I+PGUCPHJg+L/cvLII+Wro9FBns0MCqyvxHA
         NR0A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of sdias@qualcomm.com designates 129.46.98.28 as permitted sender) smtp.mailfrom=sdias@qualcomm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of sdias@qualcomm.com designates 129.46.98.28 as permitted sender) smtp.mailfrom=sdias@qualcomm.com
X-IronPort-AV: E=Sophos;i="5.49,333,1520924400";
   d="scan'208";a="17167528"
X-IronPort-AV: E=McAfee;i="5900,7806,8875"; a="147817301"
From: Sujeev Dias <sdias@codeaurora.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>
Cc: Sujeev Dias <sdias@codeaurora.org>,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	Tony Truong <truong@codeaurora.org>
Subject: MHI initial design review
Date: Thu, 26 Apr 2018 19:23:27 -0700
Message-Id: <1524795811-21399-1-git-send-email-sdias@codeaurora.org>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598864306669172400?=
X-GMAIL-MSGID: =?utf-8?q?1598864306669172400?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Greg Kroah-Hartman\All

This is the initial submit of Modem Host Interface (MHI) stack for upstream
consideration. MHI is a communication protocol to communicate with external
Qualcomm modems and Wi-Fi chipsets over high speed peripheral buses. Even
though MHI doesn’t dictate underlying physical layer, protocol and mhi stack
is structured for PCIe based devices.

For additional details related to MHI interface please see Documentation/mhi.txt.

MHI stack partitioned into three main components:
1. Core layer  handles all MHI protocol specific actions such as firmware download,
   and data transfer
   /drivers/bus/mhi/core/*
2. Control layer  bus master, manages power transitions of external modem.
  /drivers/bus/mhi/controllers/*
3. Device drivers  MHI channels (physical transport channels) exposed as mhi devices
   for clients to send and receive data.
  /drivers/bus/mhi/device/*

There are three ways which clients can interface with MHI framework to send and receive
data from external modem.

1. Register directly with mhi core layer as a mhi device driver
2. User space clients can interface via mhi_uci driver.
3. For net traffic, mhi_netdev can be used.

Can you please do a high-level design review of the MHI driver and let me know if I need to
make any design changes before the drivers can be considered for upstream.

Thanks
Sujeev

   
