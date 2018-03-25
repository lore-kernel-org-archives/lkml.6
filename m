Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752660AbeCYMBY (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Mar 2018 08:01:24 -0400
Received: from mail-he1eur01on0129.outbound.protection.outlook.com ([104.47.0.129]:59648
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752008AbeCYMBU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Mar 2018 08:01:20 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
Subject: Re: [RFC PATCH 2/3] drm: bridge: panel: allow override of the bus
 format
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Sean Paul <seanpaul@chromium.org>, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
References: <20180317221525.18534-1-peda@axentia.se>
 <20180317221525.18534-3-peda@axentia.se> <7015227.p44CVkfgjM@avalon>
From: Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <e0f5d89d-83ee-31ae-0b48-e34fe94883c5@axentia.se>
Date: Sun, 25 Mar 2018 14:01:11 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <7015227.p44CVkfgjM@avalon>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR0802CA0018.eurprd08.prod.outlook.com
 (2603:10a6:3:bd::28) To HE1PR0202MB2778.eurprd02.prod.outlook.com
 (2603:10a6:3:e8::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cc98ff51-d8d8-4faf-21e0-08d592481cf5
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4604075)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:HE1PR0202MB2778;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2778;3:fdUmTFMjeZGGFn2ywb8ANZ6oYCYg3RnBnvlGHxo4B6j4gtTfYGOaAiFfN6G2PrTdEH3SyIRgvFgBjvRViSNDnJlSACxr8kt1JQjji7R5fsa05Kg6/Uj29NPI9MAvIXjYIh5SVpp4zu7tn7DyTmTmbbu7GLFiOaTOh04pfz+dNFqn2GnZ4ZWYViDtpaa8rzbBh6hoOFIZ5BqLYwujlj0nCuwkT1vGzKDMiQiXVtlXhKnRbTjEyRzMgaRWUnptOI0z;25:ZtS7iqp77nZtrYjhO4QVk+6T6r4QWlhtkLolf1QAveeaF7/VpdnqH2Xo4OEY+M1mgjHfsNnizgGUvsRCeHXVijWlC8v5bOW2lH70yDep5m9RfdQLf2MCdRyb4y1/n60w8pR5yIZOCVAQxnKg9/hqyICT1SkRGWiBcef51o/bruDziEgvoVIDs4EIafyaUmXnKI9YDar9QpeE+GOqZ96mxc8nRulf3lXV8CP6xirbOt4jEX3/d1srPnfv0KlFR6ntpvW/IR1BDHkwDJZ8Y2U4IhL/eT3921UI/P0N3+7OzM5UGJ2aOvmgYee9Vx+AV2veFkRL2uA0e695UUH4KuCftQ==;31:y6oAXGgaJbrt5eeQBC+lxymtCQs5vr0MB9D/xulTWd5Y5j79HqDAOhTqYerFcbhHmJw1gaJ/Uwn4O82bVpfDd95Gtws0dXBYhRZ/SZ6YNLRQauw3LdIASc4GCD9PfWIz/DM2+Z22nnOM5/KFZDWqFzZC/M49CCHZBYo57D9c7wGLdDChtvSp+Z0yOnSd19xByUnuuDrlz5i6N8IpABJ62zEEAZYJ0wVhQ1e2EvNjPTk=
X-MS-TrafficTypeDiagnostic: HE1PR0202MB2778:
X-Microsoft-Antispam-PRVS: <HE1PR0202MB27789E30CA2F43948786D194BCAE0@HE1PR0202MB2778.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231221)(944501327)(52105095)(6041310)(20161123558120)(20161123564045)(20161123560045)(2016111802025)(20161123562045)(6043046)(6072148)(201708071742011);SRVR:HE1PR0202MB2778;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0202MB2778;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2778;4:J+GLaZvzjUc0QjZRipG8Qf5Fk+h0xKdAqFQLFRwJse8ERsKppnykzBX+/wvuSf9t8mbLS8XJSqVtDwezqJEjmUN1SlFqy2PwrJcD060Q35nMmmT48jJA6+HCxj91mzPkRVTEynqDdk4qXhEAdHZ8lWtz9opuKzx3MQ8qdLdNKEcGDO/quAqcSsKAyCtiflmaj0XwbQvnu+VhydLt7dipU3dEqRVuvcQcyUGVwaUXujefPNjtOaikW7JoJKDBHOam5JzbkzURDSeSjMJTT8xRkg==
X-Forefront-PRVS: 0622A98CD5
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(39830400003)(366004)(376002)(346002)(396003)(39380400002)(51914003)(199004)(189003)(377424004)(26005)(2486003)(23676004)(36916002)(186003)(16526019)(7416002)(316002)(77096007)(2906002)(106356001)(105586002)(64126003)(16576012)(76176011)(50466002)(7736002)(65826007)(345774005)(97736004)(31686004)(86362001)(52146003)(74482002)(386003)(59450400001)(305945005)(54906003)(53546011)(31696002)(4326008)(3846002)(6116002)(58126008)(52116002)(5660300001)(229853002)(6246003)(53936002)(7520500002)(956004)(2616005)(68736007)(36756003)(117156002)(478600001)(6486002)(65806001)(65956001)(66066001)(230700001)(47776003)(81166006)(3260700006)(6916009)(25786009)(8936002)(6666003)(446003)(11346002)(81156014)(8676002)(42262002)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0202MB2778;H:[192.168.13.3];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjAyMDJNQjI3Nzg7MjM6VGRPQ3JJT3pvNCtQK1QzQ1VybkRUWllr?=
 =?utf-8?B?Rm1RSlFtMTJQeVlwWFRnWDljZXVYSlNKYjFBcG5MMGZlOHF0WWxNRXlpWDNN?=
 =?utf-8?B?dVhIZ0lhemFNMjVLRFZuU1l1bDFvTGJ6R2ZiUmYwTXQxVDN1L2FhemdzTGZL?=
 =?utf-8?B?N0d2TDdOSHN4ejVBeDllUDlmVFZ1SmNrUzkyMFNOcWlqRXBUcTAzTnZKamli?=
 =?utf-8?B?cDZ0Q2FFOFhtdTdTV015L09rMWVFTWtGNXI4RDQzMEJralk1ZTBGb01jZUxx?=
 =?utf-8?B?dFVIZytReHBSSXJNdy9xcEVXaHpGRGpqbzlPM3poZkFRNGZkZ2QwYUNHdmU0?=
 =?utf-8?B?ZTdxZDdSNkRDTUt1UEJ6VXhoai83RFJYS2pidnMzTm5zUEN0U3Q2bHhRUXFa?=
 =?utf-8?B?UHhJK002bGFEdVZ6RmwyeTBCKzUvZXBNOE9VYmI0dE92cXFmaTBOdXBqNG5z?=
 =?utf-8?B?RHVodXljUE53OWNHM3htZkRYcEpqRmc2VHk1amhlU1pBQWk4cVQ4cWpOQkEw?=
 =?utf-8?B?QnZiVmoxNzEra3h3cEZSZ0grQ2Jqc3ZTUHhBaGRDSjk2M2hzaTJzaW9HVUNY?=
 =?utf-8?B?RmZDaEs4UmROdHBENjd4QnBSMnpQOXFhcTNJWkUzeXBPaHVvKzd6YUpzT2Ry?=
 =?utf-8?B?eGJkRmVydjM5QWQwUDduQlRsZ1RPaE1oa3VKVWl1SzdoZ0wycWdrL1B4SG1i?=
 =?utf-8?B?Y2MvNGVPdG0ycGVHR0R1eEJEWTZtQWtxQld2NytjYy9BK2UzTjByczNkTXVL?=
 =?utf-8?B?STI5ejVXQkJaTjRYek5icElyYWkwMTFleVB3SWtha0I1RzEzQTJXNHk0eVkx?=
 =?utf-8?B?TmlBbTR4SWlaZU1MV0VIY3NXNTYrZVRnc3dDQmtXTmQ2aGw0bWczbC9tQnN6?=
 =?utf-8?B?QzFBZkJZNVBzR3RBekt5K2J6WkQxTnI0QUFEVkE4a2VkMThvTmQ5eFJNTE1s?=
 =?utf-8?B?UTIyNndlTkVXajVCOENaZ3B0b0VpUTVlWTl5OGV4Ri9heExjNU5IR1ZSZnBh?=
 =?utf-8?B?YnJIWmxKTDhpM3hXS2hSL1BwWElQOFVuUlJNQjhuUmd2b3llNmU4aGx3MldF?=
 =?utf-8?B?VGptL1RvR2JGeTZ6N1lqV0J0dDlBNTBoL3VDejBab1o3OVd1cE5iZzJNV3Vt?=
 =?utf-8?B?TXdOQ1dYZjI4N0xkb0lUbWRMYlNxb0tyS1lSVEpGeTVlRU1QSG1WWkI2bDZR?=
 =?utf-8?B?aEk0NXhxMlhVUjdQZlhHNTVkdHRWTVhjOTZLL1RUQ3Bya1FYa091bzU1YzI4?=
 =?utf-8?B?aFViMENmMCs0aUo2blVDVVZYUzBPcWl6YWdMVmhCSkl3eklXUGhhTzQyMmVO?=
 =?utf-8?B?WHV4aXZmUWUwY1NaeXIyY21YY0VKeW1yOEtCWndveTlwd2pvUnVJOVFBbW5n?=
 =?utf-8?B?YmJxWDZ2b3htYmU1OEN1N2xwWDlhTmd6NXdlc2JuYklLN0NnTEFselM0eFRq?=
 =?utf-8?B?OFVqRTRNcHplaHBBS0laMFpEL05CUWZDQUU1MkJUZTZPZ3pkVjJQeGtLQTNY?=
 =?utf-8?B?V0laSUc5MVArMk1KTHJHVDlwak5odGlmWmV2N25ZeU1oSmxVTEdEOWkzWmI5?=
 =?utf-8?B?UG1JT2hOd1FPTUFjdkFCL2l0dTc4am9VLzQ0UmlEZ1lFdUhSaEhOWGV0czdL?=
 =?utf-8?B?QTZsV1E5SjVRMHVmTkFPN1BSMXBPRG82Yk5OdUFPZkJoWXA2SnByOHZYTjdz?=
 =?utf-8?B?WHkzYlBFdWN2V1V6aHdNK0FoRlBJcy9lNWxsVisySzZnN2xQT0xERzBXZnAy?=
 =?utf-8?B?SW5NYTNZZEQ1Tjd0Nmp6Y1JZd2hsaDRnSFE2N1kzZnpoak9vQlhESlNlQWg5?=
 =?utf-8?B?K2lOZndhNnBIbTRjOG9nZkZXMHlvSXNRQ2NiWDkwYmtlbUhYRjU2N0FFcUh1?=
 =?utf-8?B?K2dBazVCODBQWlZXVStLUURJcTI2TlhveGZrbUZCQ2JJMG5UMFhDTDZtU2Jm?=
 =?utf-8?B?bFp1UkM0WEIrZGw2THZRSG9DdlFWRzFuaExBbkx6UVNHSk1BU2NGbDFYbk5h?=
 =?utf-8?B?Z2x0c3k1dzJ5ZlBrZGtMVDhPVExGbWdDUEcwSFhQNlo4KzNRR0dQY0FmVmZt?=
 =?utf-8?B?NWVnVlBrcm1sTFBWMUFKVVNPc3BSYmlkVXUrbG5nWXRqNzZCSFh5UmkzbnQ4?=
 =?utf-8?B?ZmF6NEJNVDY3UjU5Yy9CU2NFMkZOSVZDdWUwNEkvQ1NLZHlJeVZrNngxWlZ6?=
 =?utf-8?B?dXR6NjFsOUFIKzdPSzZUZ1VuWXlSUEZUSmF1SWJtMVFYM1o0cGUxRlV2QWp2?=
 =?utf-8?B?RGRsUXo0YnV6eVhiZlVnRkpuODUzYzJsbjhpdmN5YlpDcm95U212OFd3PT0=?=
X-Microsoft-Antispam-Message-Info: 4RZqBTewMLHsvzHX6kJ/GtKAmvevyxEYRodoqptc2Xi6jhpY/DgoX+RZWxgQD2qZifhEOEDrLSOtu2Ym9mBf6PEeAQHGwca/kWMq2fzRqFSTvRom6NDkhKp0RfASKn5phdy8htBBq5Je0R3kkflGMWaT+EiX9Iyb1nQGGyiTXlBBT9XTRenW0Rw11OTWijEf
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2778;6:Gh+K+TulA+kVd+8f2DvlU7t3Z0m7xkmVGQlQeNtYotebZ7TY6bH9ZVanLtQOdyUwYUaazQcNyZYbJKOqgU1y4OjMWU62OwCzDZtWJye1XBStE4qA6f44LKSJmh7ajqUys2aJ/DNyeSIsA8ArL344tvMbpT2zf74YNyxbWr266s6w+Yf35yhcczK2aOR1LNcp2hemr07TbuSyNJNDjiVSAabs5EEPUrnRn4KEEl5nsyzw2Gf+xRMdeaGyQxIPq9JswBEt8So/AK73sbm86X6IYJFGLdN3WKuQvgLA+Ia455WQrrwKB047DbvGthwFHaAyR4eIaQL9p0DhA2s2F0OMnt2R31/D+kbIox/wxDmgLwn7P1Uy0WxQx67hvbwiYkWk1tR5Tts2MhHTiZNVE+Vhy306QIeoWWCowhn8NFDpt6WV06vv7J1dhUzGKXxlPTsfKXy9y+WavE+0DqB+uFnCWA==;5:oW6R3zjjkRVjEOruOK86b3s+6TD5AxqCKwEbDBvzUVQ45vTWQRZkB+NoGURV/pe3gaRonfVN8kdI+mzJR00xhKvTQSvBx8Zdn1Y3CqGPlmZTiaFIM21zVsQFNb5GQ7kMyb9XFo1mBuBTdeddFlUn+k7hBY6cOFsf58h1xs2i69o=;24:hL2vG1lXs7MZaWcGlpQAqDKMb/dlDgoeghOt4toWczE8zK2XImsndb1CYHqn/EVaqlrOsyHXR4WVxagqYXCITywawC/jUkzWUOzMsIUjYBc=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2778;7:Bpkyy4SwVyqX4tItw4ipEEPuQGVZF6XclOZUtRKxs7pUm3a8gGOt+Q9C+84CpWvJDHRSyluQ7qnnIFIjeKnZPQRiNKcskaRLWSqtqnXy5k/O+CRvcJx0nqfZoz8RCDbm/IfYFXaWiC6iLRWZaWfRrD5fFZc4dAXVX9tr0z1v57pV4MFeFhX7ysbP6rsJFpLH57usl4VplMxTcwtUrYWp3Sej3tnc/auHTxpVnx+cKax4VLNHeIIZeZLTeGr4n0Rw
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2018 12:01:15.9233 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc98ff51-d8d8-4faf-21e0-08d592481cf5
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0202MB2778
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

Thanks for the feedback!

On 2018-03-20 14:56, Laurent Pinchart wrote:
> Hi Peter,
> 
> Thank you for the patch.
> 
> On Sunday, 18 March 2018 00:15:24 EET Peter Rosin wrote:
>> Useful if the bridge does some kind of conversion of the bus format.
>>
>> Signed-off-by: Peter Rosin <peda@axentia.se>
>> ---
>>  drivers/gpu/drm/bridge/panel.c | 22 +++++++++++++++++++++-
>>  include/drm/drm_bridge.h       |  1 +
>>  2 files changed, 22 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/bridge/panel.c b/drivers/gpu/drm/bridge/panel.c
>> index 6d99d4a3beb3..ccef0283ff41 100644
>> --- a/drivers/gpu/drm/bridge/panel.c
>> +++ b/drivers/gpu/drm/bridge/panel.c
>> @@ -22,6 +22,7 @@ struct panel_bridge {
>>  	struct drm_connector connector;
>>  	struct drm_panel *panel;
>>  	u32 connector_type;
>> +	u32 bus_format;
>>  };
>>
>>  static inline struct panel_bridge *
>> @@ -40,8 +41,15 @@ static int panel_bridge_connector_get_modes(struct
>> drm_connector *connector) {
>>  	struct panel_bridge *panel_bridge =
>>  		drm_connector_to_panel_bridge(connector);
>> +	int ret;
>> +
>> +	ret = drm_panel_get_modes(panel_bridge->panel);
>> +
>> +	if (panel_bridge->bus_format)
>> +		drm_display_info_set_bus_formats(&connector->display_info,
>> +						 &panel_bridge->bus_format, 1);
> 
> While I agree with the problem statement and, to some extent, the DT bindings, 
> I don't think this is the right implementation. You've correctly noted that 
> display controller shouldn't blindly use the formats reported by the panel 
> through the connector formats, and that hacking the panel driver to override 
> the formats isn't a good idea, so I wouldn't override the formats reported by 
> the connector. I would instead extend the drm_bridge API to report formats at 
> bridge inputs. This would be more generic and allow each bridge to configure 
> itself according to the next bridge in the chain.
> 
> I'm not sure whether this API extension should be in the form of a new bridge 
> function, or if the formats should be stored in the drm_bridge structure 
> directly as done for connectors in the display info structure. I'm tempted by 
> the former, but I'm open to discussions.

Ok, I can look into that, but let me check if I got this right. From the very
little of the code that I have looked at, I have gathered that display
controllers handle bridges explicitly, right? If so, by extending the bridge
(with either a new function or new data) you impose changes to all display
controllers wanting to handle this new bridge input-format. If so, I assume
I can leave out the changes to all display controllers that I do not care
about. Correct?

Also, don't hold your breath waiting for a v2, but I'll try to get to it :-)

>> -	return drm_panel_get_modes(panel_bridge->panel);
>> +	return ret;
>>  }
>>
>>  static const struct drm_connector_helper_funcs
>> @@ -203,6 +211,18 @@ void drm_panel_bridge_remove(struct drm_bridge *bridge)
>> }
>>  EXPORT_SYMBOL(drm_panel_bridge_remove);
>>
>> +void drm_panel_bridge_set_bus_format(struct drm_bridge *bridge, u32
>> bus_format) +{
>> +	struct panel_bridge *panel_bridge;
>> +
>> +	if (!bridge)
>> +		return;
>> +
>> +	panel_bridge = drm_bridge_to_panel_bridge(bridge);
>> +	panel_bridge->bus_format = bus_format;
>> +}
>> +EXPORT_SYMBOL(drm_panel_bridge_set_bus_format);
>> +
>>  static void devm_drm_panel_bridge_release(struct device *dev, void *res)
>>  {
>>  	struct drm_bridge **bridge = res;
>> diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
>> index 682d01ba920c..81903b92f187 100644
>> --- a/include/drm/drm_bridge.h
>> +++ b/include/drm/drm_bridge.h
>> @@ -268,6 +268,7 @@ void drm_bridge_enable(struct drm_bridge *bridge);
>>  struct drm_bridge *drm_panel_bridge_add(struct drm_panel *panel,
>>  					u32 connector_type);
>>  void drm_panel_bridge_remove(struct drm_bridge *bridge);
>> +void drm_panel_bridge_set_bus_format(struct drm_bridge *bridge, u32
>> bus_format);
>> struct drm_bridge *devm_drm_panel_bridge_add(struct device
>> *dev,
>>  					     struct drm_panel *panel,
>>  					     u32 connector_type);
> 
