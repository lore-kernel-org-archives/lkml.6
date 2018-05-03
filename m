Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751646AbeECS7l (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 14:59:41 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:38602 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751349AbeECS6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 14:58:47 -0400
X-Google-Smtp-Source: AB8JxZpcBSqNI80vJ9Jkrd5rFr8p8oSzTQNp9rpmiN8pdr0HaTWsnLtQj3W5LOzjVtBAvX7smmH5KhX9SgVwdCuPTVU=
MIME-Version: 1.0
In-Reply-To: <20180503185342.zawmhazzvkkdc3ja@kozik-lap>
References: <20180502201153.7459-1-malat@debian.org> <20180503184454.19131-1-malat@debian.org>
 <20180503185342.zawmhazzvkkdc3ja@kozik-lap>
From: Mathieu Malaterre <malat@debian.org>
Date: Thu, 3 May 2018 20:58:25 +0200
X-Google-Sender-Auth: puLLrFM3ZKM4B6nYzoFNXjhb5ic
Message-ID: <CA+7wUswQDXZTXWFd=mwo8ehFxHkOp0UA-RuO_fVBzoj-7mutSg@mail.gmail.com>
Subject: Re: [PATCH v3] arm: exynos/s3c: dts: Remove leading 0x and 0s from
 bindings notation
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 3, 2018 at 8:53 PM, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> On Thu, May 03, 2018 at 08:44:53PM +0200, Mathieu Malaterre wrote:
>> Improve the DTS files by removing all the leading "0x" and zeros to fix the
>> following dtc warnings:
>>
>> Warning (unit_address_format): Node /XXX unit name should not have leading "0x"
>>
>> and
>>
>> Warning (unit_address_format): Node /XXX unit name should not have leading 0s
>>
>> Converted using the following command:
>>
>> find . -type f \( -iname *.dts -o -iname *.dtsi \) -exec sed  -i -e "s/@\([0-9a-fA-FxX\.;:#]\+\)\s*{/@\L\1 {/g" -e "s/@0x\(.*\) {/@\1 {/g" -e "s/@0\+\(.*\) {/@\1 {/g" {} +
>
> The firmware node is fixed but in my case the command is doing much
> more:

Looks like I cannot copy/paste correctly, meant to say:

find . -type f \( -iname "*.dts" -o -iname "*.dtsi" \) -exec sed  -i
-e "s/@\([0-9a-fA-FxX\.;:#]\+\)\s*{/@\L\1 {/g" -e "s/@0x\(.*\) {/@\1
{/g" -e "s/@0\+\(.\+\) {/@\1 {/g" {} +

> -                       smp-sysram@0 {
> +                       smp-sysram@ {
>
> -                       port@0 {
> +                       port@ {
>
> Best regards,
> Krzysztof
