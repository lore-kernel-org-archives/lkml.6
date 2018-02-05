Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752820AbeBEGKA (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 01:10:00 -0500
Received: from mail-qk0-f193.google.com ([209.85.220.193]:46474 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752919AbeBEGJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 01:09:12 -0500
X-Google-Smtp-Source: AH8x225y4kvjSAyKw0pIxOAdWP+oCYaYDafl0Bb8QCKVdazmn/j3P+b06ckNbQcalpUO/+MY+nxkU9WVfRXeLN2MIHo=
MIME-Version: 1.0
In-Reply-To: <20180205023654.77yq7j22ovby2ql5@rob-hp-laptop>
References: <20180130055116.17411-1-joel@jms.id.au> <20180130055116.17411-2-joel@jms.id.au>
 <20180205023654.77yq7j22ovby2ql5@rob-hp-laptop>
From: Joel Stanley <joel@jms.id.au>
Date: Mon, 5 Feb 2018 16:38:50 +1030
X-Google-Sender-Auth: hTvnS6cvlJM0WF96pZhY0F2yocM
Message-ID: <CACPK8Xfrr+7Oh04_6+AX=Y_8wdvb4ALVGgepCQftvLwHn+J+XQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: fsi: Add optional property no-scan-on-init
To: Rob Herring <robh@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        Christopher Bostic <cbostic@linux.vnet.ibm.com>,
        Jeremy Kerr <jk@ozlabs.org>, Eddie James <eajames@linux.vnet.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 5, 2018 at 4:37 PM, Rob Herring <robh@kernel.org> wrote:
> On Tue, Jan 30, 2018 at 04:21:15PM +1030, Joel Stanley wrote:
>> From: Christopher Bostic <cbostic@linux.vnet.ibm.com>
>>
>> Add an optional FSI master property 'no-scan-on-init.  This
>> can be specified to indicate that a master should not be
>> automatically scanned at init time.  This is required in cases
>> where a scan could interfere with another FSI master on the same
>> bus.
>>
>> Signed-off-by: Christopher Bostic <cbostic@linux.vnet.ibm.com>
>> Acked-by: Jeremy Kerr <jk@ozlabs.org>
>> Signed-off-by: Joel Stanley <joel@jms.id.au>
>> ---
>>  Documentation/devicetree/bindings/fsi/fsi.txt | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/fsi/fsi.txt b/Documentation/devicetree/bindings/fsi/fsi.txt
>> index 4eaf488d4015..ab516c673a4b 100644
>> --- a/Documentation/devicetree/bindings/fsi/fsi.txt
>> +++ b/Documentation/devicetree/bindings/fsi/fsi.txt
>> @@ -56,6 +56,13 @@ addresses (link index and slave ID), and no size:
>>      #address-cells = <2>;
>>      #size-cells = <0>;
>>
>> +An optional boolean property can be added to indicate that a particular master
>> +should not scan for connected devices at initialization time.  This is
>> +necessary in cases where a scan could cause arbitration issues with other
>> +masters that may be present on the bus.
>> +
>> +    no-scan-on-init;
>> +
>
> The formatting here is a bit strange compared to most bindings, but no
> point in reformatting the document to add one property.

I'll keep that in mind next time we're working in this area.

Thanks Rob.

>
> Reviewed-by: Rob Herring <robh@kernel.org>
>
> Rob
