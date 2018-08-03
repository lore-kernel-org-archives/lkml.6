Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C63D7C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 13:22:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 744E0216FD
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 13:22:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 744E0216FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=apache.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732257AbeHCPSV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 11:18:21 -0400
Received: from hermes.apache.org ([140.211.11.3]:27582 "HELO mail.apache.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729811AbeHCPSU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 11:18:20 -0400
Received: (qmail 83865 invoked by uid 99); 3 Aug 2018 13:22:00 -0000
Received: from mail-relay.apache.org (HELO mailrelay2-lw-us.apache.org) (207.244.88.137)
    by apache.org (qpsmtpd/0.29) with ESMTP; Fri, 03 Aug 2018 13:22:00 +0000
Received: from [192.168.1.54] (unknown [92.86.115.230])
        by mailrelay2-lw-us.apache.org (ASF Mail Server at mailrelay2-lw-us.apache.org) with ESMTPSA id 9D3521F11;
        Fri,  3 Aug 2018 13:21:58 +0000 (UTC)
Message-ID: <393a529f40e7d61493178a1baeee5e2679c7da11.camel@apache.org>
Subject: Re: [PATCH 2/2] HID: redragon Add additional verification to rdesc
 modification quirk
From:   Robert Munteanu <rombert@apache.org>
To:     John S Gruber <JohnSGruber@gmail.com>,
        Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org,
        benjamin.tissoires@redhat.com, dmitry.torokhov@gmail.com,
        linux-kernel@vger.kernel.org
Date:   Fri, 03 Aug 2018 16:21:56 +0300
In-Reply-To: <CAPotdmQh_sWqPmiQ=_+fJ27AT7GA5hcne=wsXcmKhNnUpUs3wQ@mail.gmail.com>
References: <CAPotdmQtXmfHJfcgrXZ02NrPgS3Az=SpZnBsRZ_8dGvPfdi+Mw@mail.gmail.com>
         <1532807605-26023-1-git-send-email-JohnSGruber@gmail.com>
         <CAPotdmQh_sWqPmiQ=_+fJ27AT7GA5hcne=wsXcmKhNnUpUs3wQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.4 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2018-07-28 at 15:53 -0400, John S Gruber wrote:
> There are many devices using the vendor_id 0c45 and device_id of 760b
> combination. Also the two bytes 0x81 0x00 aren't rare for a report
> description. For these reasons the report description being altered
> by the quirk should be verified more completely
> 
> If I'm understanding this correctly, I believe for an array field the
> report_size should be greater or equal to
> ceil(log2(usage_maximum - usage_minimum + 1)). That's 3 bits for
> these 8
> shift keys, 0xe0-0xe7. Therefore the incorrect report description
> can't
> be valid for any device.
> 
> Check the actual count of the rdesc and compare the entire field
> description to reduce the chance of patching the wrong thing by
> inadvertence.
> 
> Signed-off-by: John S Gruber <JohnSGruber@gmail.com>

I tested this on 4.17.11 with 85455dd906d5 and cbe7e3ad0eab from Jiri's
for-4.19/upstream tree and it works just fine.

Feel free to add

  Acked-By: Robert Munteanu <rombert@apache.org>

Thanks for looking into this.

Robert

