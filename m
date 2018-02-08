Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751756AbeBHHkC (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 02:40:02 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:56289 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750930AbeBHHkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 02:40:01 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180208073958euoutp02d086e67c7068a87a04b7f6ce8c4d7f46~RSbbRz_m23040530405euoutp02p
X-AuditID: cbfec7f5-f79d06d0000031c7-6c-5a7bfecd8f29
Subject: Re: [PATCH] drm/bridge/synopsys: dsi: Add read feature
To: Philippe Cornu <philippe.cornu@st.com>,
        Archit Taneja <architt@codeaurora.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Brian Norris <briannorris@chromium.org>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Bhumika Goyal <bhumirks@gmail.com>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Sandy Huang <hjc@rock-chips.com>,
        Heiko Stubner <heiko@sntech.de>, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Cc: Yannick Fertre <yannick.fertre@st.com>,
        Vincent Abriou <vincent.abriou@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
From: Andrzej Hajda <a.hajda@samsung.com>
Message-id: <a1a17a6e-8389-e04f-716e-29b10b295b54@samsung.com>
Date: Thu, 08 Feb 2018 08:39:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.6.0
MIME-version: 1.0
In-reply-to: <20180204213104.17834-1-philippe.cornu@st.com>
Content-type: text/plain; charset="utf-8"
Content-transfer-encoding: 7bit
Content-language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01SaUhUYRTlm7fMc3DkNWreLBImg5TSIqNnlhZEvUKhMCQNqSmfS67MqLgQ
        DZrTqGm5NNa4kyZFJGloiZWZaWqu44KVC7kg2qRmholLMz4D/51z7rn3u+fyUZhET1hTQWGR
        nDxMFiIlRXhV49/2fW2r8T77q3qdmbT2ZgHzYqwVMQlqPcEk1LeQzK+huyRTMTdDMD0LMySz
        9n2aYPIzbzDJGSVCpmK0j2B0NXkG28gaxozcmiSYz711OHM7OYk8TrO5yi6c1aWnCdjX2kEh
        m6t+SLDf+mpJtvrPCMEOpzYJ2MqSm+yK9h3OVvcVYOz44huMna/Yec7UR3TUjwsJiubkjq5X
        RIE/hzsFET0oZkxXQyjRc5SCKApoJ2if3JaCTAxwK3QOlZMpSERJ6FIEPRktQp7MI8hXTQt5
        lxPoih5tuB4jWK5LxHkygaD/TjsyusxpN+ioSxQYCxZ0Ag59Y3mYkWC0EsFEvoY0ukjaDlYq
        B0jjImLaFfTlvkYZp3dD2bhaYMSW9EUovj++PlRMb4HFrCHciE1oF9AXatcxZhgz+TtzA9tA
        5TM9xmMrSEwaWN8O6EYhpBemkXyGk1CSxzcDbQ5TTS83su0AXVbqRkMqgpa3yRhPshF0TOkE
        vMsFPjR1EfwTZpBZlYPxpxSDWiXhLSwk9AwSvHwCstck/InSEWhTy8h7yEa7KZB2UwjtphDa
        TSGKEP4UWXBRitAATnHIQSELVUSFBThcCw+tQIZP2LratPAKlTYeqUc0haSm4lnneB8JIYtW
        xIbWI6AwqYX4jLtBEvvJYuM4efhleVQIp6hH2ylcaiU+5qPyltABskgumOMiOPn/qoAysVai
        3NqrpzOC96j8P2oWwH3J1ev8F6VGIpvpFl2PUy+4mHWVrVJP/B74DnvbFAQ32GlscwKa3V0s
        22zLMz/trSFVh7O6Y7qXrVHxzMH3bo4eeQ3+gfOznuaeySvCBizuwin7udquoR9eo+VeZzWV
        Ecvpvpes7PptY5cid3nEjI6qv0pxRaDsgD0mV8j+Aa74RgaAAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIIsWRmVeSWpSXmKPExsVy+t/xq7pn/1VHGRzex2/Re+4kk8XGJ6cZ
        LZo63rJaNB06xWbx6V4/m8Wmj+9ZLa58fc9m8f/Ra1aLuZNqLTonLmG32PT4GqvF5V1zgMoe
        /Ge2eNDygtXizNUDLBbtna1sDgIesxsusnhc7utl8tg56y67x+yOmawed67tYfPY/u0Bq8f9
        7uNMHpuX1Hv8nbWfxWP7tXnMHk9/7GX2+LxJLoAnissmJTUnsyy1SN8ugSvj3f0LTAVXGCue
        XN7F2sC4jrGLkZNDQsBE4vKCxWwQtpjEhXvrgWwuDiGBJYwSKw4dh3KeMUrs/94CViUsYC9x
        /kAzE0hCRKCFRWLv05tgVcwCTYwSV77uYodomcAoserKYmaQFjYBTYm/m0GqODh4Bewk3q6P
        BQmzCKhKLH/awQRiiwpESHSunM8CYvMKCEr8mHwPzOYUsJZ4O38WC0grs4C6xJQpuSBhZgF5
        ic1r3jJD2OISza03WSYwCs5C0j0LoWMWko5ZSDoWMLKsYhRJLS3OTc8tNtIrTswtLs1L10vO
        z93ECIzYbcd+btnB2PUu+BCjAAejEg/vB8vqKCHWxLLiytxDjBIczEoivJ4+QCHelMTKqtSi
        /Pii0pzU4kOM0hwsSuK85w0qo4QE0hNLUrNTUwtSi2CyTBycUg2MIvxXl22Oclheks7Ey3Db
        /MzLL9NCxfUaK/o6zt9fNpWT/ZGRULzjjKvmp6989Hd8GyjZqTDF/v/2ulUVqreslLdLzd/q
        ahC03dTxW4iMo1rNFKudAjeMm5jvKDbNcs1zKvzs7+m5X/VILYNLe0q1d8whg1Q15eK82OM+
        K5k2330zJT5Y/rASS3FGoqEWc1FxIgAbgU0A1AIAAA==
X-CMS-MailID: 20180208073957eucas1p1b3e6410ef677aaa2b5416239972bd8b3
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180204213219epcas2p429434ba0c87a0544dc5294facd80529b
X-RootMTR: 20180204213219epcas2p429434ba0c87a0544dc5294facd80529b
References: <CGME20180204213219epcas2p429434ba0c87a0544dc5294facd80529b@epcas2p4.samsung.com>
        <20180204213104.17834-1-philippe.cornu@st.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.02.2018 22:31, Philippe Cornu wrote:
> This patch adds the DCS/GENERIC DSI read feature.
>
> Signed-off-by: Philippe Cornu <philippe.cornu@st.com>
> ---
Queued to drm-misc-next.
--
Regards
Andrzej
