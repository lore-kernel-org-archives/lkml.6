Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751994AbeD1Vac (ORCPT <rfc822;w@1wt.eu>);
        Sat, 28 Apr 2018 17:30:32 -0400
Received: from mout.gmx.net ([212.227.17.21]:35447 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751151AbeD1Vab (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Apr 2018 17:30:31 -0400
MIME-Version: 1.0
Message-ID: <trinity-b6e4284e-0ab8-45f5-bf10-467f775e4d43-1524951029803@3c-app-gmx-bs73>
From: "John Smith" <john-s-84@gmx.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3.18 18/52] HID: i2c-hid: fix size check and type usage
Content-Type: text/plain; charset=UTF-8
Date: Sat, 28 Apr 2018 23:30:29 +0200
Importance: normal
Sensitivity: Normal
References: <trinity-0dcac895-4529-4180-924f-ccbb1284323c-1524949271985@3c-app-gmx-bs13>
 <trinity-bff38853-2a86-4917-a956-4688923718e1-1524949392271@3c-app-gmx-bs13>
 <trinity-89e26547-70eb-4dbb-a1f5-45ed0521f340-1524949740067@3c-app-gmx-bs73>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:Nc74xovWl5r4cXaAlZPIul9kAapsNt1obQ5eOqFk88G
 njXCYnyp1l2Dh1pMP2uE2C0Z/0HaznbwY7k+PO+9e/qMHVl72w
 cySaG06N6hwjejKuh6cP/40zU+ygQoAnJ4s/j/4d2I7LkJY8zg
 y87FWIFmulctxuwnTdtcPjO2s7vf7a1m+SKd/uyn+EBjr8oa7/
 WzWb5N9daU8HDp8zDy3bp7xptAN8cz8R1/ckwo0EhzmeAZktR/
 eT6j/G+gNBGj4CKDixRKwR4afls9a6Zvx/vZEqMJ2vqIa86Olv JRioyk=
X-UI-Out-Filterresults: notjunk:1;V01:K0:6aOZK9UNsyM=:RxjnPZgs2Gk+5DTcxUDoe+
 YCHK/HO+JmZu3RNFze/PPnDq+L2jloUpOfoOFllmcX2uruFVUUn+9rIGbD2ZVi479z2ODv3pS
 HB6KrnFfaNZa4a6QYS87rBCKD7ZoPkXvWCRYh+tlTqXXgt/7SFF6hgWeIrOpQm+c4F5CZVRcy
 nBp1XzTVZzupdMmJLdg6bunIxiMrLwTPGMyRiZLiFSCH38a3DmfdHmcMCOV61rCNoj4arsNEJ
 EplvyIszJH7mQpSiiSPBcFCLZeVYZh2S5UOc0TnI8UTgEpqJvo54LrFv1dW/e9zAXUeRTF7la
 CfnImZdN/qxChRZQX31iWV9AKWlfJmrMavc+yEC4Qpcv/kVtpHTakh06jLCPXyYgKAaTJraoi
 imwecAcMQD9X0zKvyfxMyFnqiZ04Q+BivMd+tioWlxbn5LtNv/LwpVmDKdWGu1kP2IM60C+fO
 dP+l8prKk/z1Hr0/tZYPJkhSpKso+hY9wdywuChDu4UxFr1Umswc
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> - if (ret_size > size) {
> + if ((ret_size > size) || (ret_size <= 2)) {
> dev_err(&ihid->client->dev, "%s: incomplete report (%d/%d)\n",
> __func__, size, ret_size);
> return;


This change spams in the dmesg output. Could you please undo this change? Or

- if ((ret_size > size) || (ret_size <= 2)) {
+ if ((ret_size > size) || (ret_size < 2)) {


$ dmesg

[ 1781.266353] i2c_hid i2c-ALP0017:00: i2c_hid_get_input: incomplete report (30/2)
[ 1781.273898] i2c_hid i2c-ALP0017:00: i2c_hid_get_input: incomplete report (30/2)
[ 1781.281464] i2c_hid i2c-ALP0017:00: i2c_hid_get_input: incomplete report (30/2)
[ 1781.289064] i2c_hid i2c-ALP0017:00: i2c_hid_get_input: incomplete report (30/2)
[ 1781.296607] i2c_hid i2c-ALP0017:00: i2c_hid_get_input: incomplete report (30/2)
[ 1781.304131] i2c_hid i2c-ALP0017:00: i2c_hid_get_input: incomplete report (30/2)
[ 1781.311751] i2c_hid i2c-ALP0017:00: i2c_hid_get_input: incomplete report (30/2)
[ 1781.319315] i2c_hid i2c-ALP0017:00: i2c_hid_get_input: incomplete report (30/2)
[ 1781.326882] i2c_hid i2c-ALP0017:00: i2c_hid_get_input: incomplete report (30/2)
